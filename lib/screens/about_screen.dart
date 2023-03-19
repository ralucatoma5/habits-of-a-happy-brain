import 'package:flutter/material.dart';

import '../const.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          expandedHeight: verticalBlock * 10,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: const Color(0xffF4F4F4),
            ),
          ),
          title: Text(
            'About the app',
            style: TextStyle(
                color: Colors.black,
                fontSize: verticalBlock * 3.7,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
        ),
        SliverToBoxAdapter(
            child: SizedBox(
          width: double.maxFinite,
          height: verticalBlock * 150,
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color(0xffF4F4F4),
                    width: double.maxFinite,
                    height: verticalBlock * 50,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: verticalBlock * 10),
                      child: SizedBox(
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
                    ),
                  )),
              Positioned(
                  top: verticalBlock * 42,
                  bottom: 0,
                  child: Container(
                    width: horizontalBlock * 100,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: verticalBlock * 3,
                          left: horizontalBlock * 8,
                          right: horizontalBlock * 8,
                          bottom: verticalBlock * 5),
                      child: Text(
                          'An app designed to boost your happiness in just 45 days! "Habits of a Happy Brain" shows you how to retrain your brain to turn on the chemicals that make you happy. Each chapter offers simple activities that help you understand the roles of your “happy chemicals”—serotonin, dopamine, oxytocin, and endorphin. You’ll also learn how to build new habits by rerouting the electricity in your brain to flow down a new pathway, making it even easier to trigger these happy chemicals and increase feelings of satisfaction when you need them most. Filled with dozens of exercises that will help you reprogram your brain, Habits of a Happy Brain shows you how to live a happier, healthier life!',
                          style: readingText),
                    ),
                  ))
            ],
          ),
        ))
      ],
    ));
  }
}
