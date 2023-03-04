import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../const.dart';
import 'chapter_screen.dart';

class SubchapterScreen extends StatefulWidget {
  final QueryDocumentSnapshot document;
  int ind;
  final List<QueryDocumentSnapshot> list;
  final int screenIndex;
  SubchapterScreen(
      {Key? key,
      required this.document,
      required this.ind,
      required this.screenIndex,
      required this.list})
      : super(key: key);

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
              padding: EdgeInsets.only(
                  top: verticalBlock * 2, right: horizontalBlock * 2),
            ),
            expandedTitleScale: 1.15,
            centerTitle: false,
            title: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: horizontalBlock * 70,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: safeareaVertical * 8,
                      left: 0,
                      right: horizontalBlock * 4),
                  child: Text(widget.document['subtitles'][widget.ind],
                      style: TextStyle(
                        color: blue,
                        fontSize:
                            wordNr(widget.document['subtitles'][widget.ind]) < 3
                                ? verticalBlock * 3.8
                                : verticalBlock * 2.8,
                        fontWeight: FontWeight.w800,
                      )),
                )),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: wordNr(widget.document['subtitles'][widget.ind]) < 2
              ? verticalBlock * 9
              : verticalBlock * 14,
          leading: IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalBlock * 4, vertical: verticalBlock * 2),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: ChapterScreen(widget.screenIndex,
                        document: widget.document, list: widget.list),
                  ));
            },
            icon: Icon(Icons.adaptive.arrow_back,
                size: verticalBlock * 3, color: blue),
          ),
          centerTitle: false,
          leadingWidth: verticalBlock * 3,
          expandedHeight: wordNr(widget.document['subtitles'][widget.ind]) < 2
              ? verticalBlock * 10
              : verticalBlock * 15,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalBlock * 5, vertical: verticalBlock),
                child: Text(widget.document['subtitle_description'][widget.ind],
                    style: readingText),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: horizontalBlock * 8,
                  left: horizontalBlock * 8,
                  bottom: verticalBlock * 6,
                ),
                child: widget.screenIndex == 4 || widget.screenIndex == 0
                    ? SizedBox(height: verticalBlock * 3)
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget
                            .document['example']['example${widget.ind}'].length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: verticalBlock * 0.5,
                                  horizontal: 0.0),
                              leading: Container(
                                width: verticalBlock * 2.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: blue),
                              ),
                              title: Text(
                                  widget.document['example']
                                      ['example${widget.ind}'][index],
                                  style: readingText));
                        }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: verticalBlock * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget.ind > 0
                        ? SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                    child: SubchapterScreen(
                                      document: widget.document,
                                      ind: widget.ind - 1,
                                      screenIndex: widget.screenIndex,
                                      list: widget.list,
                                    ),
                                    type: PageTransitionType.leftToRight,
                                  ));
                                },
                                style: buttonStyle(blue),
                                child: Text('Previous',
                                    style: buttonTextStyle(Colors.white, 4))),
                          )
                        : SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                          ),
                    widget.document['subtitles'].length > widget.ind + 1
                        ? SizedBox(
                            width: verticalBlock * 14,
                            height: verticalBlock * 6,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                  child: SubchapterScreen(
                                    document: widget.document,
                                    ind: widget.ind + 1,
                                    screenIndex: widget.screenIndex,
                                    list: widget.list,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                ));
                              },
                              style: buttonStyle(blue),
                              child: Text('Next',
                                  style: buttonTextStyle(Colors.white, 4)),
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
