import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habits/screens/home_screen.dart';
import 'package:habits/screens/myhabit_screet.dart';
import 'package:page_transition/page_transition.dart';

import '../const.dart';

class CongratsScreen extends StatelessWidget {
  final Function()? delete;
  final Function(int nrd) updateDay;
  String type;
  int nrday;
  CongratsScreen(
      {super.key,
      required this.nrday,
      required this.delete,
      required this.updateDay,
      required this.type});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: verticalBlock * 5,
            ),
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
                        fontSize: verticalBlock * 3,
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
                  ? delete
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
      ],
    );
  }
}
