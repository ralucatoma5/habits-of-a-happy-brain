import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../const.dart';
import 'healthyhabits_screen.dart';
import 'home_screen.dart';
import 'subchapter_screen.dart';

class ChapterScreen extends StatelessWidget {
  final int screenIndex;
  final QueryDocumentSnapshot document;
  final List<QueryDocumentSnapshot> list;

  ChapterScreen(this.screenIndex,
      {super.key, required this.document, required this.list});

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Positioned(
          top: SizeConfig.safeBlockVertical! * 8,
          left: SizeConfig.safeBlockHorizontal! * 5,
          child: IconButton(
            icon: Icon(
              Icons.adaptive.arrow_back,
              size: verticalBlock * 3.5,
            ),
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                child: HomeScreen(),
                duration: Duration(milliseconds: 300),
                type: PageTransitionType.leftToRight,
              ));
            },
          )),
      Padding(
        padding: EdgeInsets.only(
            top: verticalBlock * 24, left: horizontalBlock * 15),
        child: Container(
          width: horizontalBlock * 85,
          color: const Color(0xffF7F7F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: verticalBlock * 2.5,
                    horizontal: horizontalBlock * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          width: horizontalBlock * 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${screenIndex + 1}.',
                                  style: TextStyle(
                                      fontSize: verticalBlock * 4,
                                      fontWeight: FontWeight.w800)),
                              SizedBox(
                                height: verticalBlock * 18,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: verticalBlock * 2.5,
                                  ),
                                  child: Text(document['name'],
                                      style: TextStyle(
                                          fontSize: verticalBlock * 3,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: verticalBlock * 23),
                    Text('About the chapter',
                        style: TextStyle(
                          fontSize: verticalBlock * 3,
                          fontWeight: FontWeight.w700,
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalBlock * 2),
                      child: Text(document['summary'],
                          style: TextStyle(
                              fontSize: verticalBlock * 2.5,
                              letterSpacing: 0.1,
                              height: 1.4,
                              color: const Color(0xff848181))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
          top: verticalBlock * 17,
          left: 0,
          child: Hero(
            tag: screenIndex,
            child: Container(
              height: verticalBlock * 30,
              width: horizontalBlock * 50,
              decoration: BoxDecoration(
                boxShadow: [containerShadow],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                child: Image.asset(
                  document['img'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )),
      Positioned(
        top: verticalBlock * 52,
        right: 0,
        left: 0,
        child: SizedBox(
          height: verticalBlock * 18,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: document['subtitles'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: horizontalBlock * 5, bottom: verticalBlock * 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: verticalBlock * 2,
                      vertical: verticalBlock,
                    ),
                    width: horizontalBlock * 47,
                    decoration: BoxDecoration(
                      boxShadow: [containerShadow],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: verticalBlock),
                        Text(
                          document['subtitles'][index],
                          style: TextStyle(
                              color: blue,
                              fontSize:
                                  wordNr(document['subtitles'][index]) == 1
                                      ? verticalBlock * 2.5
                                      : verticalBlock * 2,
                              fontWeight: FontWeight.w800),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(Icons.adaptive.arrow_forward),
                            iconSize: verticalBlock * 2,
                            color: blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screenIndex == 5
                                        ? HealthyHabits(
                                            document: document, ind: index)
                                        : SubchapterScreen(
                                            document: document,
                                            ind: index,
                                            screenIndex: screenIndex,
                                            list: list,
                                          )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      )
    ])));
  }
}
