import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits/screens/congrats_screen.dart';
import 'package:habits/screens/habit_screen.dart';

import '../const.dart';

import 'home_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final now = DateTime.now();

  Duration duration = const Duration(minutes: 10);
  Timer? timer;
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  final refh = FirebaseFirestore.instance
      .collection('habit')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email);
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

  void stopTimer({bool reset = true}) {
    if (reset) resetTimer();

    setState(() {
      timer?.cancel();
    });
  }

  Future<void> delete() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('habit');
    _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).delete();
  }

  Future<void> deleteHabit(BuildContext context) async {
    Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                      "Are you sure you want to stop building this habit"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: delete,
                      child: const Text("Yes"),
                    ),
                  ],
                ))
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: const Text(
                      "Are you sure you want to stop building this habit"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("No"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: const Text("Yes"),
                      onPressed: () {
                        delete();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
  }

  Future<void> stopHabit(BuildContext context) async {
    Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                      "You missed at least a day of your habit, so you have to start over"),
                  actions: [
                    TextButton(
                      onPressed: delete,
                      child: const Text("Ok"),
                    ),
                  ],
                ))
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: const Text(
                      "You missed at least a day of your habit, so you have to start over"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("OK"),
                      onPressed: () {
                        delete();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
  }

  Future updateDay(int nrday) async {
    resetTimer();
    final _collectionRef = FirebaseFirestore.instance.collection('habit');
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'nrday': nrday});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blue,
        body: StreamBuilder(
            stream: refh.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                DateTime time = DateTime.parse(
                    snapshot.data!.docs[0]['time'].toDate().toString());
                final initialDay = DateTime(time.year, time.month, time.day);
                int nrday = snapshot.data!.docs[0]['nrday'].toInt();

                final today = DateTime(time.year, time.month, time.day + nrday);
                return duration.inSeconds != 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalBlock * 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: horizontalBlock * 45,
                                      child: Text(
                                          snapshot.data!.docs[0]['name'],
                                          style: TextStyle(
                                              fontSize: verticalBlock * 3,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Text('${(nrday * 100.00 / 45).round()}%',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text('About the habit',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
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
                                              summary: snapshot.data!.docs[0]
                                                  ['summary'],
                                              description: snapshot
                                                  .data!.docs[0]['description'],
                                              name: snapshot.data!.docs[0]
                                                  ['name'],
                                              type: snapshot.data!.docs[0]
                                                  ['type'],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () => deleteHabit(context),
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
                                today ==
                                        DateTime(
                                            now.year, now.month, now.day + 1)
                                    ? 'Wait until tomorrow'
                                    : 'Day ${nrday + 1}',
                                style: TextStyle(
                                    fontSize: verticalBlock * 4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                            buildTimer(),
                            buildButtons(today),
                          ],
                        ),
                      )
                    : CongratsScreen(
                        nrday: nrday,
                        delete: delete,
                        updateDay: updateDay,
                        type: 'timer');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
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
                  isRunning
                      ? stopTimer(reset: false)
                      : startTimer(reset: false);
                },
                style: buttonStyle(Colors.white),
                child: Text(isRunning ? 'Pause' : 'Resume',
                    style: buttonTextStyle(blue, 5)),
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
            child: Text('Start timer', style: buttonTextStyle(blue, 5)),
            onPressed: today == DateTime(now.year, now.month, now.day + 1)
                ? () {}
                : today == DateTime(now.year, now.month, now.day)
                    ? () {
                        startTimer();
                      }
                    : () => stopHabit(context));
  }

  Widget buildTimer() => SizedBox(
        width: verticalBlock * 32,
        height: verticalBlock * 32,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(pink),
              value: duration.inSeconds / 600,
              backgroundColor: Color.fromARGB(255, 25, 95, 139),
            ),
            Center(child: buildTime())
          ],
        ),
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text('$minutes:$seconds',
        style: TextStyle(fontSize: verticalBlock * 5, color: Colors.white));
  }
}
