import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/screens/home_screen.dart';

class MyHabitScreen extends StatefulWidget {
  const MyHabitScreen({Key? key}) : super(key: key);

  @override
  _MyHabitScreenState createState() => _MyHabitScreenState();
}

class _MyHabitScreenState extends State<MyHabitScreen> {
  Duration duration = Duration(minutes: 10);
  Timer? timer;
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  void resetTimer() => setState(() => duration = Duration(minutes: 10));

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

  Widget buildButtons() {
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
            onPressed: () {
              startTimer();
            });
  }

  Widget buildTimer() => SizedBox(
        width: verticalBlock * 35,
        height: verticalBlock * 35,
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
    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: verticalBlock * 6, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('habit')
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Some error occurred ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: blue,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: horizontalBlock * 45,
                        child: Text(snapshot.data!.docs[0]['name'],
                            style: TextStyle(
                                fontSize: verticalBlock * 3,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                      Column(
                        children: [
                          const Text('60%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: verticalBlock * 1.5),
                            child: Container(
                              height: 1.0,
                              width: horizontalBlock * 15,
                              color: pink,
                            ),
                          ),
                          GestureDetector(
                            child: Text('About the habit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Text('Day 3',
                      style: TextStyle(
                          fontSize: verticalBlock * 5,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  buildTimer(),
                  buildButtons()
                ],
              ),
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
