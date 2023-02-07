import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/screens/healthyhabits_screen.dart';
import 'package:habits/screens/home_screen.dart';
import 'package:habits/screens/reading_screen.dart';
import 'package:habits/screens/subchapter_screen.dart';
import 'package:page_transition/page_transition.dart';

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
          top: SizeConfig.safeBlockVertical! * 6.5,
          left: SizeConfig.safeBlockHorizontal! * 5,
          child: IconButton(
            icon: Icon(
              Icons.adaptive.arrow_back,
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
            top: verticalBlock * 22, left: horizontalBlock * 15),
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
                    SizedBox(height: verticalBlock * 26),
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
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: verticalBlock * 3,
                        vertical: verticalBlock * 3),
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Finished Chapter',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: verticalBlock * 2,
                          fontWeight: FontWeight.w700),
                    ),
                  ))
            ],
          ),
        ),
      ),
      Positioned(
          top: verticalBlock * 15,
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
        top: verticalBlock * 50,
        right: 0,
        left: 0,
        child: SizedBox(
          height: verticalBlock * 20,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: document['subtitles'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: horizontalBlock * 5, bottom: verticalBlock * 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: verticalBlock * 2, vertical: verticalBlock),
                    width: horizontalBlock * 47,
                    decoration: BoxDecoration(
                      boxShadow: [containerShadow],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/dopamine.png',
                            height: verticalBlock * 3,
                          ),
                        ),
                        Text(
                          document['subtitles'][index],
                          style: TextStyle(
                              color: blue,
                              fontSize:
                                  wordNr(document['subtitles'][index]) == 1
                                      ? verticalBlock * 3
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
