import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:habits/models/currentHabit_model.dart';
import 'package:habits/models/habit_model.dart';
import 'package:habits/screens/congrats_screen.dart';
import 'package:habits/screens/habit_screen.dart';
import 'package:habits/services/firestoreService.dart';

import '../const.dart';

import '../habitFunctions.dart';

class TimerScreen extends StatefulWidget {
  CurrentHabit currentHabit;

  TimerScreen({super.key, required this.currentHabit});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final now = DateTime.now();

  Duration duration = const Duration(minutes: 10);
  Timer? timer;
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  void resetTimer() => setState(() => duration = const Duration(minutes: 10));

  void startTimer({bool reset = true}) {
    if (reset) resetTimer();
    timer = Timer.periodic(
        Duration(seconds: 1),
        (_) => duration.inSeconds > 0
            ? setState(() {
                int seconds = duration.inSeconds - 1;
                duration = Duration(seconds: seconds);
              })
            : stopTimer(reset: false));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      timer = Timer.periodic(Duration(seconds: 0), (_) => stopTimer());
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void stopTimer({bool reset = true}) {
    if (reset) resetTimer();

    setState(() {
      timer?.cancel();
    });
  }

  Future updateDay(int nrday) async {
    resetTimer();

    return currentHabitCollection.doc(FirebaseAuth.instance.currentUser!.email).update({'nrday': nrday});
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(widget.currentHabit.time.toString());
    final today = DateTime(time.year, time.month, time.day + widget.currentHabit.nrday);
    return Scaffold(
      backgroundColor: duration.inSeconds != 0 ? blue : Colors.white,
      body: duration.inSeconds != 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: horizontalBlock * 45,
                            child: Text(widget.currentHabit.name,
                                style: TextStyle(
                                    fontSize: verticalBlock * 3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Text('${(widget.currentHabit.nrday * 100.00 / 45).round()}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: verticalBlock * 2.3)),
                        ],
                      ),
                      SizedBox(
                        height: verticalBlock * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text('About the habit',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: pink,
                                  fontWeight: FontWeight.w600,
                                  fontSize: verticalBlock * 2.4,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HabitScreen(
                                    index: 4,
                                    habit: Habit(
                                        name: widget.currentHabit.name,
                                        description: widget.currentHabit.description,
                                        summary: widget.currentHabit.summary,
                                        type: widget.currentHabit.type,
                                        id: widget.currentHabit.id),
                                    finishedHabit: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () => deleteHabit(context, 'timer'),
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                size: verticalBlock * 4.5,
                                color: pink,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Text(
                      today == DateTime(now.year, now.month, now.day + 1)
                          ? 'Wait until tomorrow'
                          : 'Day ${widget.currentHabit.nrday + 1}',
                      style: TextStyle(
                          fontSize: verticalBlock * 4, color: Colors.white, fontWeight: FontWeight.w700)),
                  buildTimer(),
                  buildButtons(today),
                ],
              ),
            )
          : CongratsScreen(
              name: widget.currentHabit.name,
              nrday: widget.currentHabit.nrday,
              updateDay: updateDay,
              type: 'timer'),
    );
  }

  Widget buildButtons(today) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0 || duration.inMinutes == 10;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  isRunning ? stopTimer(reset: false) : startTimer(reset: false);
                },
                style: buttonStyle(Colors.white),
                child: Text(isRunning ? 'Pause' : 'Resume', style: buttonTextStyle(blue, 5)),
              ),
              SizedBox(
                width: horizontalBlock * 10,
              ),
              TextButton(
                onPressed: () {
                  stopTimer();
                },
                style: buttonStyle(Colors.white),
                child: Text('Cancel', style: buttonTextStyle(blue, 5)),
              ),
            ],
          )
        : TextButton(
            style: buttonStyle(Colors.white),
            onPressed: today == DateTime(now.year, now.month, now.day + 1)
                ? () {}
                : today == DateTime(now.year, now.month, now.day)
                    ? () {
                        startTimer();
                      }
                    : () => startOverHabit(context, 'timer'),
            child: Text('Start timer', style: buttonTextStyle(blue, 5)));
  }

  Widget buildTimer() => SizedBox(
        width: verticalBlock * 32,
        height: verticalBlock * 32,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(pink),
              value: duration.inSeconds / 600,
              backgroundColor: const Color.fromARGB(255, 25, 95, 139),
            ),
            Center(child: buildTime())
          ],
        ),
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text('$minutes:$seconds', style: TextStyle(fontSize: verticalBlock * 5, color: Colors.white));
  }
}
