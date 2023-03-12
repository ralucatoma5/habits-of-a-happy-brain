import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../const.dart';
import 'habit_screen.dart';

class HealthyHabits extends StatelessWidget {
  final QueryDocumentSnapshot document;
  final int ind;
  HealthyHabits({Key? key, required this.document, required this.ind})
      : super(key: key);

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  final safeareaVertical = SizeConfig.safeBlockVertical!;

  bool contains(List<String> list, String name) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] == name) return true;
    }
    return false;
  }

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
                        padding: EdgeInsets.only(right: horizontalBlock * 6),
                        child: Text(snapshot.data!.docs[ind]['name'],
                            style: TextStyle(
                              color: blue,
                              fontSize:
                                  wordNr(snapshot.data!.docs[ind]['name']) < 3
                                      ? verticalBlock * 3.4
                                      : verticalBlock * 3.1,
                              fontWeight: FontWeight.w800,
                            )),
                      )),
                ),
                backgroundColor: Colors.white,
                toolbarHeight: verticalBlock * 13,
                leading: IconButton(
                  padding: EdgeInsets.only(
                      left: horizontalBlock * 5, top: verticalBlock * 2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.adaptive.arrow_back,
                      size: verticalBlock * 4, color: blue),
                ),
                centerTitle: false,
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
                      mainAxisSpacing: verticalBlock * 4,
                      crossAxisSpacing: horizontalBlock * 4,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        String name =
                            snapshot.data!.docs[ind]['habits_name'][index];
                        String description = snapshot.data!.docs[ind]
                            ['habits_description'][index];
                        String summary =
                            snapshot.data!.docs[ind]['habits_summary'][index];
                        String type = snapshot.data!.docs[ind]['type'][index];
                        bool finishedHabit = false;
                        return GestureDetector(
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
                                        color:
                                            circleColor(index).withOpacity(0.7),
                                      ),
                                    )),
                                Positioned(
                                  top: verticalBlock * 2,
                                  left: horizontalBlock * 3,
                                  child: snapshot.data!.docs[ind]['type']
                                              [index] ==
                                          'write'
                                      ? Image.asset(
                                          'assets/images/write-icon.png',
                                          height: verticalBlock * 5,
                                        )
                                      : Icon(Icons.timer_outlined,
                                          size: verticalBlock * 5),
                                ),
                                FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('finishedHabits')
                                      .where('id',
                                          isEqualTo: FirebaseAuth
                                              .instance.currentUser!.email)
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot
                                          .data!.docs[0]['finishedHabits']
                                          .contains(name)) {
                                        finishedHabit = true;
                                        return Positioned(
                                          top: verticalBlock * 2,
                                          right: horizontalBlock * 3,
                                          child: Icon(
                                              Icons.check_circle_outline,
                                              size: verticalBlock * 5,
                                              color: blue),
                                        );
                                      }
                                    }
                                    return const SizedBox();
                                  },
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
                                        fontSize: verticalBlock * 2.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HabitScreen(
                                    index: index,
                                    name: name,
                                    description: description,
                                    summary: summary,
                                    type: type,
                                    finishedHabit: finishedHabit),
                              ),
                            );
                          },
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(
                            1, index == 1 || index == 3 ? 1.40 : 1.30);
                      },
                    ))
              ]))
            ]));
          }
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
