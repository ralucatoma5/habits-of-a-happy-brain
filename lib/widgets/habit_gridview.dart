import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:habits/const.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habits/models/habit_model.dart';
import 'package:habits/screens/habit_screen.dart';
import 'package:habits/services/firestoreService.dart';

class HabitTypeGridView extends StatefulWidget {
  final id;
  final ScrollController controller;
  const HabitTypeGridView({super.key, required this.id, required this.controller});

  @override
  State<HabitTypeGridView> createState() => _HabitTypeGridViewState();
}

class _HabitTypeGridViewState extends State<HabitTypeGridView> {
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('habits').where('id', isEqualTo: widget.id).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator.adaptive();
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                      left: horizontalBlock * 4, right: horizontalBlock * 4, top: verticalBlock * 4),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    itemCount: snapshot.data!.docs.length,
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
                                    if (snapshot.data!.docs[0]['finishedHabits'].contains(habit.name)) {
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
                                bottom: verticalBlock * 4,
                                left: horizontalBlock * 6,
                                child: SizedBox(
                                  width: horizontalBlock * 35,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
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
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HabitScreen(index: index, habit: habit, finishedHabit: finishedHabit),
                            ),
                          );
                        },
                      );
                    },
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, index == 1 || index == 3 ? 1.35 : 1.45);
                    },
                  ),
                );
              }
            }));
  }
}
