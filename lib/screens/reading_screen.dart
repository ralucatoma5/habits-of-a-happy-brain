// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/models/chapter.dart';
import 'package:habits/screens/about_screen.dart';
import 'package:habits/screens/chapter_screen.dart';
import 'package:habits/screens/subchapter_screen.dart';
import 'package:page_transition/page_transition.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 1,
          flexibleSpace: FlexibleSpaceBar(
            title: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxHeight > verticalBlock * 15
                  ? const Text('')
                  : Text('Habits of a Happy Brain',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: verticalBlock * 3.3,
                          fontWeight: FontWeight.w800));
            }),
            background: Column(children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: verticalBlock * 23,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/images/homepage.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: horizontalBlock * 80,
                    child: Text(
                      'Feel good while doing things that are actually good for you',
                      style: TextStyle(
                          fontSize: verticalBlock * 2.5,
                          color: Colors.white,
                          height: 1.5,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalBlock * 10,
                              vertical: verticalBlock * 1.3),
                          height: verticalBlock * 9,
                          width: double.infinity,
                          color: blue,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Habits of a',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: verticalBlock * 3.2,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalBlock * 10,
                              vertical: verticalBlock * 1.3),
                          height: verticalBlock * 9,
                          width: double.infinity,
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Happy Brain',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: verticalBlock * 3.3,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalBlock * 6),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: About(),
                              ));
                        },
                        child: Container(
                          height: verticalBlock * 8,
                          width: verticalBlock * 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [containerShadow],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(verticalBlock * 1.5),
                            child: Image.asset(
                              'assets/images/brain-icon.png',
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ]),
          ),
          pinned: true,
          expandedHeight: verticalBlock * 40,
          backgroundColor: Colors.white,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: verticalBlock * 3.5),
                      child: SizedBox(
                        width: double.infinity,
                        height: verticalBlock * 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                right: horizontalBlock * 5,
                                child: Hero(
                                  tag: index,
                                  child: Container(
                                    height: verticalBlock * 30,
                                    width: horizontalBlock * 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [containerShadow],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        'assets/images/chapter1.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )),
                            Positioned(
                              right: horizontalBlock * 50,
                              child: Container(
                                height: verticalBlock * 25,
                                width: horizontalBlock * 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [containerShadow],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(verticalBlock * 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('1.',
                                          style: TextStyle(
                                              fontSize: verticalBlock * 3.5,
                                              fontWeight: FontWeight.w800)),
                                      Text('Your Inner Mammal',
                                          style: TextStyle(
                                              fontSize: verticalBlock * 2.8,
                                              fontWeight: FontWeight.w600)),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  PageTransition(
                                                    child: ChapterScreen(index),
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade,
                                                    duration: const Duration(
                                                        milliseconds: 650),
                                                    reverseDuration:
                                                        const Duration(
                                                            milliseconds: 600),
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons
                                                  .adaptive.arrow_forward)))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
