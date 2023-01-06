import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/screens/chapter_screen.dart';
import 'package:page_transition/page_transition.dart';

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
                  top: verticalBlock * 4, right: horizontalBlock * 2),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/dopamine.png',
                  height: verticalBlock * 6,
                ),
              ),
            ),
            expandedTitleScale: 1.15,
            centerTitle: false,
            title: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: horizontalBlock * 70,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: safeareaVertical * 4,
                      left: 0,
                      right: horizontalBlock * 4),
                  child: Text(widget.document['subtitles'][widget.ind],
                      style: TextStyle(
                        color: blue,
                        fontSize: verticalBlock * 3.3,
                        fontWeight: FontWeight.w800,
                      )),
                )),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: verticalBlock * 12,
          leading: IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalBlock * 4, vertical: verticalBlock * 3),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterScreen(widget.screenIndex,
                        document: widget.document, list: widget.list)),
              );
            },
            icon: Icon(Icons.adaptive.arrow_back,
                size: verticalBlock * 3, color: blue),
          ),
          centerTitle: false,
          leadingWidth: verticalBlock * 3,
          expandedHeight: verticalBlock * 17,
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
                child: widget.screenIndex == 4
                    ? SizedBox(height: verticalBlock * 3)
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
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
                                  widget.document['exemple']
                                      ['exemple${widget.ind}'][index],
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
                            child: OutlinedButton(
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
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: horizontalBlock * 3.8,
                                        vertical: verticalBlock * 1.5),
                                    backgroundColor: const Color(0xff006FA9)
                                        .withOpacity(0.4),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    side: BorderSide(color: blue, width: 2)),
                                child: Text('Previous',
                                    style: TextStyle(
                                        color: blue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: horizontalBlock * 4))),
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
                              style: TextButton.styleFrom(
                                backgroundColor: blue,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              child: Text('Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: horizontalBlock * 4)),
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
