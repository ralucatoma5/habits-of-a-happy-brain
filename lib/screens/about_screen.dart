import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/models/about_model.dart';
import 'package:habits/services/firestoreService.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: aboutCollection.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                About about = About.fromJSON(snapshot.data!.docs[0]);
                return CustomScrollView(
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
                        about.title,
                        style: TextStyle(
                            color: Colors.black, fontSize: verticalBlock * 3.7, fontWeight: FontWeight.w600),
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
                                        about.backgroundImg,
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
                                          about.mainImg,
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
                                        topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: verticalBlock * 3,
                                      left: horizontalBlock * 8,
                                      right: horizontalBlock * 8,
                                      bottom: verticalBlock * 5),
                                  child: Text(about.content, style: readingText),
                                ),
                              ))
                        ],
                      ),
                    ))
                  ],
                );
              }
            }));
  }
}
