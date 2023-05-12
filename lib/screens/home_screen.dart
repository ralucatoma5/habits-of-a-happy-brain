import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/models/chapter_model.dart';
import 'package:habits/services/firestoreService.dart';

import 'package:page_transition/page_transition.dart';

import 'about_screen.dart';
import 'chapter_screen.dart';

class ReadingScreen extends StatefulWidget {
  final ScrollController controller;

  const ReadingScreen({super.key, required this.controller});

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.controller,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          expandedHeight: verticalBlock * 45,
          flexibleSpace: FlexibleSpaceBar(
            title: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxHeight > verticalBlock * 15
                  ? const Text('')
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: verticalBlock * 2),
                      child: Text('Habits of a Happy Brain',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: verticalBlock * 3.3,
                              fontWeight: FontWeight.w800)),
                    );
            }),
            background: Column(children: [
              Stack(
                children: [
                  SizedBox(
                    height: verticalBlock * 27,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/images/homepage.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: verticalBlock * 4, bottom: verticalBlock),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  FirebaseAuth.instance.signOut();
                                });
                              },
                              icon: const Icon(Icons.logout),
                              color: Colors.white,
                              iconSize: verticalBlock * 2.7,
                            ),
                          ],
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
                ],
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalBlock * 10, vertical: verticalBlock * 1.3),
                          height: verticalBlock * 10,
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
                              horizontal: horizontalBlock * 10, vertical: verticalBlock * 1.3),
                          height: verticalBlock * 10,
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
                    padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 6),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: AboutScreen(),
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
            collapseMode: CollapseMode.pin,
          ),
          toolbarHeight: verticalBlock * 10,
          pinned: true,
          backgroundColor: Colors.white,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              StreamBuilder<QuerySnapshot>(
                  stream: chaptersCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(bottom: verticalBlock * 4),
                        child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.only(bottom: verticalBlock),
                            itemBuilder: (context, index) {
                              Chapter chapter = Chapter.fromJSON(snapshot.data!.docs[index]);
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: verticalBlock * 2.5),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: verticalBlock * 32,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                          right: horizontalBlock * 5,
                                          child: Hero(
                                            tag: index,
                                            child: Container(
                                              height: verticalBlock * 32,
                                              width: horizontalBlock * 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                boxShadow: [containerShadow],
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.asset(
                                                  chapter.imageUrl,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                        right: horizontalBlock * 50,
                                        child: Container(
                                          height: verticalBlock * 27,
                                          width: horizontalBlock * 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: [containerShadow],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: verticalBlock, horizontal: horizontalBlock * 4),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('${index + 1}.',
                                                    style: TextStyle(
                                                        fontSize: verticalBlock * 3.5,
                                                        fontWeight: FontWeight.w800)),
                                                SizedBox(
                                                  height: verticalBlock,
                                                ),
                                                Text(chapter.name,
                                                    style: TextStyle(
                                                        fontSize: verticalBlock * 2.5,
                                                        fontWeight: FontWeight.w600)),
                                                Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                            PageTransition(
                                                              child: ChapterScreen(chapter: chapter, index),
                                                              type: PageTransitionType.rightToLeftWithFade,
                                                              duration: const Duration(milliseconds: 650),
                                                              reverseDuration:
                                                                  const Duration(milliseconds: 600),
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(Icons.adaptive.arrow_forward)))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }
}
