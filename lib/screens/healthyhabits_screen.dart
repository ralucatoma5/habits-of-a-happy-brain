import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habits/models/habitType_model.dart';
import 'package:habits/models/habit_model.dart';
import 'package:habits/services/firestoreService.dart';

import '../const.dart';
import 'habit_screen.dart';

class HealthyHabits extends StatelessWidget {
  final int ind;
  HealthyHabits({Key? key, required this.ind}) : super(key: key);

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  final safeareaVertical = SizeConfig.safeBlockVertical!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('habits_categories')
                .where('id', isEqualTo: ind)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator.adaptive();
              } else {
                HabitType habitType = HabitType.fromJSON(snapshot.data!.docs[0]);
                return StreamBuilder<QuerySnapshot>(
                  stream: FirestoreService.getHabitsByType(ind),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return CustomScrollView(slivers: [
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
                                  child: Text(
                                    habitType.name,
                                    style: TextStyle(
                                      color: blue,
                                      fontSize: wordNr(habitType.name) < 3
                                          ? verticalBlock * 3.4
                                          : verticalBlock * 3.1,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )),
                          ),
                          backgroundColor: Colors.white,
                          toolbarHeight: verticalBlock * 13,
                          leading: IconButton(
                            padding: EdgeInsets.only(left: horizontalBlock * 5, top: verticalBlock * 2),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.adaptive.arrow_back, size: verticalBlock * 4, color: blue),
                          ),
                          centerTitle: false,
                          expandedHeight: wordNr(habitType.name) < 3 ? verticalBlock * 8 : verticalBlock * 15,
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
                                  Habit habit = Habit.fromJSON(snapshot.data!.docs[index]);
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
                                                height: verticalBlock * circleHeight(index),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: circleColor(index).withOpacity(0.7),
                                                ),
                                              )),
                                          Positioned(
                                            top: verticalBlock * 2,
                                            left: horizontalBlock * 3,
                                            child: habit.type == 'write'
                                                ? Image.asset(
                                                    'assets/images/write-icon.png',
                                                    height: verticalBlock * 5,
                                                  )
                                                : Icon(Icons.timer_outlined, size: verticalBlock * 5),
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                            stream: FirestoreService.getFinishedHabit(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                                                if (snapshot.data!.docs[0]['finishedHabits']
                                                    .contains(habit.name)) {
                                                  finishedHabit = true;
                                                  return Positioned(
                                                    top: verticalBlock * 2,
                                                    right: horizontalBlock * 3,
                                                    child: Icon(Icons.check_circle_outline,
                                                        size: verticalBlock * 5, color: blue),
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
                                                habit.name,
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
                                              index: index, habit: habit, finishedHabit: finishedHabit),
                                        ),
                                      );
                                    },
                                  );
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(1, index == 1 || index == 3 ? 1.40 : 1.30);
                                },
                              ))
                        ]))
                      ]);
                    }
                  },
                );
              }
            }));
  }
}
