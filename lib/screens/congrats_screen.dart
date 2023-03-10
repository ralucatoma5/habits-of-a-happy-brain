import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habits/habitFunctions.dart';
import 'package:habits/screens/home_screen.dart';
import 'package:habits/screens/myhabit_screet.dart';
import 'package:page_transition/page_transition.dart';

import '../const.dart';

class CongratsScreen extends StatelessWidget {
  final Function(int nrd) updateDay;
  String name;
  String type;
  int nrday;
  CongratsScreen(
      {super.key,
      required this.nrday,
      required this.updateDay,
      required this.name,
      required this.type});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: verticalBlock * 5,
              left: horizontalBlock * 3,
              right: horizontalBlock * 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                type == 'write'
                    ? 'assets/images/congrats-blue.png'
                    : 'assets/images/congrats.png',
                height: verticalBlock * 20,
              ),
              Column(
                children: [
                  Text('Congratulations!',
                      style: TextStyle(
                          fontSize: verticalBlock * 4.5,
                          color: type == 'write' ? blue : pink,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: verticalBlock * 2.5,
                  ),
                  Text(
                      nrday == 44
                          ? "You've finished building the habit"
                          : "You've finished day ${nrday + 1}",
                      style: TextStyle(
                          fontSize: verticalBlock * 2.7,
                          color: type == 'write'
                              ? const Color.fromARGB(255, 142, 141, 141)
                              : Colors.white,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(
                height: verticalBlock * 5,
              ),
              TextButton(
                onPressed: () => nrday == 44
                    ? {
                        addToFinisedHabits(name),
                        type == 'write' ? deleteNotes() : deleteTimer(),
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Scaffold(body: HomeScreen())),
                        ),
                      }
                    : {
                        updateDay(nrday + 1),
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Scaffold(body: HomeScreen())),
                        ),
                      },
                style: buttonStyle(type == 'write' ? blue : Colors.white),
                child: Text('Ok',
                    style: buttonTextStyle(
                        type == 'write' ? Colors.white : blue, 6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
