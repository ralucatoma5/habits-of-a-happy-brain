import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/models/chapter_model.dart';
import 'package:habits/models/subchapter_model.dart';
import 'package:habits/services/firestoreService.dart';

import 'package:page_transition/page_transition.dart';

import '../const.dart';
import 'first_healthyhabits.dart';
import 'bottomNavBar.dart';
import 'subchapter_screen.dart';

class ChapterScreen extends StatelessWidget {
  final int screenIndex;

  Chapter chapter;

  ChapterScreen(this.screenIndex, {super.key, required this.chapter});

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
                child: BottomNavBar(),
                duration: Duration(milliseconds: 300),
                type: PageTransitionType.leftToRight,
              ));
            },
          )),
      Padding(
        padding: EdgeInsets.only(top: verticalBlock * 24, left: horizontalBlock * 15),
        child: Container(
          width: horizontalBlock * 85,
          color: const Color(0xffF7F7F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalBlock * 2.5, horizontal: horizontalBlock * 5),
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
                                  style: TextStyle(fontSize: verticalBlock * 4, fontWeight: FontWeight.w800)),
                              SizedBox(
                                height: verticalBlock * 18,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: verticalBlock * 2.5,
                                  ),
                                  child: Text(chapter.name,
                                      style: TextStyle(
                                          fontSize: verticalBlock * 3, fontWeight: FontWeight.w700)),
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
                      padding: EdgeInsets.symmetric(vertical: verticalBlock * 2),
                      child: Text(chapter.summary,
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
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                child: Image.asset(
                  chapter.imageUrl,
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
            child: StreamBuilder<QuerySnapshot>(
                stream: FirestoreService.getSubchapters(screenIndex),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    List<Subchapter> subchapters =
                        snapshot.data!.docs.map((subchapter) => Subchapter.fromJSON(subchapter)).toList();
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: horizontalBlock * 5, bottom: verticalBlock * 5),
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
                                    subchapters[index].title,
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: wordNr(subchapters[index].title) == 1
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
                                                  ? FirstHealthyHabits(ind: index)
                                                  : SubchapterScreen(
                                                      subchapters: subchapters,
                                                      chapter: chapter,
                                                      subchapterIndex: index,
                                                      chapterIndex: screenIndex,
                                                    )),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                })),
      )
    ])));
  }
}
