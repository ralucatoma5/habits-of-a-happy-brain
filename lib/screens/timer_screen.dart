import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/screens/home_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: horizontalBlock * 45,
                child: Text('Keep Adjusting the Bar',
                    style: TextStyle(fontSize: verticalBlock * 3)),
              ),
              Column(
                children: [
                  const Text('60%'),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: verticalBlock * 1.5),
                    child: Container(
                      height: 1.0,
                      width: horizontalBlock * 15,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    child: Text('About the habit'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
          Text('Day 3', style: TextStyle(fontSize: verticalBlock * 4)),
          buildTimer(),
          buildButtons()
        ],
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0 || duration.inSeconds == 5;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Text(isRunning ? 'Pause' : 'Resume'),
                  onPressed: () {
                    isRunning
                        ? stopTimer(reset: false)
                        : startTimer(reset: false);
                  }),
              ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    stopTimer();
                  }),
            ],
          )
        : ElevatedButton(
            child: Text('Start timer'),
            onPressed: () {
              startTimer();
            });
  }

  Widget buildTimer() => SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              value: duration.inSeconds / 600,
              backgroundColor: blue,
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
      style: TextStyle(fontSize: verticalBlock * 7),
    );
  }
}
