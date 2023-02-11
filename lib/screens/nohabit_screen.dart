import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../const.dart';

class NoHabitScreen extends StatelessWidget {
  NoHabitScreen({super.key});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/molecule.png', height: verticalBlock * 30),
          Padding(
            padding: EdgeInsets.only(
                top: verticalBlock * 7, bottom: verticalBlock * 2),
            child: Text(
              'No new habit started',
              style: TextStyle(
                fontSize: verticalBlock * 3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            'Finish reading the chapters and build a new habit',
            style: TextStyle(
                fontSize: verticalBlock * 2.5,
                color: Color.fromARGB(255, 123, 122, 122)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }
}
