import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habits/const.dart';

import 'habit_screen.dart';

class HealthyHabits extends StatelessWidget {
  final QueryDocumentSnapshot document;
  final int ind;
  HealthyHabits({Key? key, required this.document, required this.ind})
      : super(key: key) {}

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  final safeareaVertical = SizeConfig.safeBlockVertical!;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('chapters')
          .doc('5')
          .collection('healthy-habits')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Some error occurred ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
                /* appBar: AppBar(
                    iconTheme: const IconThemeData(color: Colors.black),
                    toolbarHeight: verticalBlock * 10,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text(snapshot.data!.docs[ind]['name'],
                        style: TextStyle(
                          color: blue,
                          fontSize: verticalBlock * 3.7,
                          fontWeight: FontWeight.w800,
                        ))),*/
                body: CustomScrollView(slivers: [
              SliverAppBar(
                elevation: 0.8,
                flexibleSpace: FlexibleSpaceBar(
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
                        child: Text(snapshot.data!.docs[ind]['name'],
                            style: TextStyle(
                              color: blue,
                              fontSize:
                                  wordNr(snapshot.data!.docs[ind]['name']) < 3
                                      ? verticalBlock * 3.8
                                      : verticalBlock * 3.2,
                              fontWeight: FontWeight.w800,
                            )),
                      )),
                ),
                backgroundColor: Colors.white,
                toolbarHeight: verticalBlock * 10,
                leading: IconButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalBlock * 4,
                      vertical: verticalBlock * 2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.adaptive.arrow_back,
                      size: verticalBlock * 3, color: blue),
                ),
                centerTitle: false,
                leadingWidth: verticalBlock * 3,
                expandedHeight: wordNr(snapshot.data!.docs[ind]['name']) < 3
                    ? verticalBlock * 8
                    : verticalBlock * 15,
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.all(15),
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 20,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HabitScreen(
                                  index: index,
                                  name: snapshot.data!.docs[ind]['habits_name']
                                      [index],
                                  description: snapshot.data!.docs[ind]
                                      ['habits_description'][index],
                                  summary: snapshot.data!.docs[ind]
                                      ['habits_summary'][index],
                                  type: snapshot.data!.docs[ind]['type'][index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: verticalBlock * 30,
                            width: horizontalBlock * 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffF7F7F7),
                              boxShadow: [containerShadow],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: verticalBlock * topPosition(index),
                                    left: horizontalBlock * leftPosition(index),
                                    width: horizontalBlock * 40,
                                    child: Container(
                                      height:
                                          verticalBlock * circleHeight(index),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: circleColor(index)
                                            .withOpacity(0.75),
                                      ),
                                    )),
                                Positioned(
                                  top: verticalBlock * 2,
                                  right: horizontalBlock * 3,
                                  child: Image.asset(
                                    'assets/images/write-icon.png',
                                    height: verticalBlock * 5,
                                  ),
                                ),
                                Positioned(
                                  bottom: verticalBlock * 5,
                                  left: horizontalBlock * 6,
                                  child: SizedBox(
                                    width: horizontalBlock * 35,
                                    child: Text(
                                      snapshot.data!.docs[ind]['habits_name']
                                          [index],
                                      style: TextStyle(
                                        color: blue,
                                        fontSize: verticalBlock * 2.8,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(
                            1, index == 1 || index == 3 ? 1.35 : 1.55);
                      },
                    ))
              ]))
            ]));
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
