import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/models/chapter_model.dart';
import 'package:habits/models/subchapter_model.dart';

import 'package:page_transition/page_transition.dart';

import '../const.dart';
import 'chapter_screen.dart';

class SubchapterScreen extends StatefulWidget {
  int subchapterIndex;
  List<Subchapter> subchapters;
  Chapter chapter;
  final int chapterIndex;
  SubchapterScreen({
    Key? key,
    required this.subchapters,
    required this.chapter,
    required this.subchapterIndex,
    required this.chapterIndex,
  }) : super(key: key);

  @override
  State<SubchapterScreen> createState() => _SubchapterScreenState();
}

class _SubchapterScreenState extends State<SubchapterScreen> {
  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  final safeareaVertical = SizeConfig.safeBlockVertical!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0.8,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsets.only(top: verticalBlock * 2, right: horizontalBlock * 2),
            ),
            expandedTitleScale: 1.15,
            centerTitle: false,
            title: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: horizontalBlock * 70,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: safeareaVertical * 8, left: 0, right: horizontalBlock * 4),
                  child: Text(widget.subchapters[widget.subchapterIndex].title,
                      style: TextStyle(
                        color: blue,
                        height: 1.3,
                        fontSize: wordNr(widget.subchapters[widget.subchapterIndex].title) < 3
                            ? verticalBlock * 3.8
                            : verticalBlock * 2.8,
                        fontWeight: FontWeight.w800,
                      )),
                )),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: wordNr(widget.subchapters[widget.subchapterIndex].title) < 2
              ? verticalBlock * 9
              : verticalBlock * 14.5,
          leading: IconButton(
            padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 4, vertical: verticalBlock * 2),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: ChapterScreen(widget.chapterIndex, chapter: widget.chapter),
                  ));
            },
            icon: Icon(Icons.adaptive.arrow_back, size: verticalBlock * 3, color: blue),
          ),
          centerTitle: false,
          leadingWidth: verticalBlock * 3,
          expandedHeight: wordNr(widget.subchapters[widget.subchapterIndex].title) < 2
              ? verticalBlock * 10
              : verticalBlock * 15,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 7, vertical: verticalBlock * 2.5),
                child: Text(widget.subchapters[widget.subchapterIndex].description, style: readingText),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: horizontalBlock * 8,
                  left: horizontalBlock * 8,
                  bottom: verticalBlock * 6,
                ),
                child: widget.chapterIndex == 0 || widget.chapterIndex == 4
                    ? SizedBox(height: verticalBlock)
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.subchapters[widget.subchapterIndex].examples.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: verticalBlock * 0.5, horizontal: 0.0),
                              leading: Container(
                                width: verticalBlock * 2.5,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: blue),
                              ),
                              title: Text(widget.subchapters[widget.subchapterIndex].examples[index],
                                  style: readingText));
                        }),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: verticalBlock * 8,
                  right: horizontalBlock * 8,
                  left: horizontalBlock * 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.subchapterIndex > 0
                        ? SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                    child: SubchapterScreen(
                                      chapter: widget.chapter,
                                      subchapters: widget.subchapters,
                                      subchapterIndex: widget.subchapterIndex - 1,
                                      chapterIndex: widget.chapterIndex,
                                    ),
                                    type: PageTransitionType.leftToRight,
                                  ));
                                },
                                style: buttonStyle(blue),
                                child: Text('Previous', style: buttonTextStyle(Colors.white, 4))),
                          )
                        : SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                          ),
                    widget.subchapters.length > widget.subchapterIndex + 1
                        ? SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                  child: SubchapterScreen(
                                    chapter: widget.chapter,
                                    subchapters: widget.subchapters,
                                    subchapterIndex: widget.subchapterIndex + 1,
                                    chapterIndex: widget.chapterIndex,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                ));
                              },
                              style: buttonStyle(blue),
                              child: Text('Next', style: buttonTextStyle(Colors.white, 4)),
                            ),
                          )
                        : SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
