import 'package:flutter/material.dart';
import 'package:habits/const.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.only(
                    top: verticalBlock * 8,
                    bottom: verticalBlock * 5,
                    left: horizontalBlock * 8),
                icon: Icon(
                  Icons.adaptive.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 25),
              child: Text(
                'App inspired by',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: verticalBlock * 3.7, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: verticalBlock * 40,
              width: double.maxFinite,
              child: Stack(alignment: Alignment.center, children: [
                Image.asset(
                  'assets/images/line.png',
                  fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: blue.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 30,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/book.png',
                    height: verticalBlock * 30,
                  ),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: horizontalBlock * 8,
                  right: horizontalBlock * 8,
                  bottom: verticalBlock * 5),
              child: Text(
                  'An app designed to boost your happiness in just 45 days! "Habits of a Happy Brain" shows you how to retrain your brain to turn on the chemicals that make you happy. Each page offers simple activities that help you understand the roles of your “happy chemicals”—serotonin, dopamine, oxytocin, and endorphin. You’ll also learn how to build new habits by rerouting the electricity in your brain to flow down a new pathway, making it even easier to trigger these happy chemicals and increase feelings of satisfaction when you need them most. Filled with dozens of exercises that will help you reprogram your brain, Habits of a Happy Brain shows you how to live a happier, healthier life!',
                  style: readingText),
            ),
          ],
        ),
      ),
    );
  }
}
