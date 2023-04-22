import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits/habitFunctions.dart';
import 'package:habits/models/currentHabit_model.dart';
import 'package:habits/models/habit_model.dart';
import 'package:habits/services/firestoreService.dart';
import 'package:habits/widgets/hideButtomNavBar_widget.dart';
import 'package:intl/intl.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../const.dart';

class HabitScreen extends StatefulWidget {
  final int index;
  Habit habit;

  final bool finishedHabit;

  HabitScreen({Key? key, required this.index, required this.habit, required this.finishedHabit})
      : super(key: key);

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  var now = DateTime.now();

  var formatter = DateFormat('dd');

  bool isCurrentHabit = false;

  bool existHabit = false;
  late CurrentHabit currentHabit;

  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future addToHabit() async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection("currentHabit");
    return collectionRef.doc(FirebaseAuth.instance.currentUser!.email).set({
      'name': widget.habit.name,
      'description': widget.habit.description,
      'summary': widget.habit.summary,
      'type': widget.habit.type,
      'id': FirebaseAuth.instance.currentUser!.email,
      'time': DateTime.now(),
      'nrday': 0
    });
  }

  Future<void> addHabit(BuildContext context) async {
    addToHabit();
    showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: const Color(0xffFEFEFE),
          icon: const Icon(Icons.circle, size: 0),
          message: "Added to your habit!",
          messagePadding: const EdgeInsets.symmetric(horizontal: 0),
          textStyle: TextStyle(color: blue, fontWeight: FontWeight.bold),
          textScaleFactor: 1.3,
        ),
        displayDuration: const Duration(milliseconds: 50));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService.getCurrentHabit(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final querySnaphots = snapshot.data;
          if (querySnaphots!.docs.isNotEmpty) {
            // document exists
            currentHabit = CurrentHabit.fromJSON(snapshot.data!.docs[0]);
            isCurrentHabit = currentHabit.name == widget.habit.name;
            existHabit = true;
          } else {
            // document does not exist
          }
          return Scaffold(
              body: SingleChildScrollView(
                controller: controller,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                      top: verticalBlock * -3,
                      right: horizontalBlock * -8,
                      child: Container(
                        height: verticalBlock * 25,
                        width: verticalBlock * 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor(widget.index).withOpacity(0.5),
                        ),
                      )),
                  Positioned(
                    top: verticalBlock * 9,
                    left: horizontalBlock * 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.adaptive.arrow_back,
                        size: verticalBlock * 3.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: verticalBlock * 9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal! * 17),
                          child: SizedBox(
                            width: horizontalBlock * 65,
                            child: Text(
                              widget.habit.name,
                              style: TextStyle(
                                  fontSize: verticalBlock * 3.6, height: 1.4, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          leading: widget.habit.type == 'write'
                              ? Image.asset(
                                  'assets/images/write-blueIcon.png',
                                  height: verticalBlock * 5,
                                )
                              : Icon(Icons.timer_outlined, color: blue, size: verticalBlock * 5),
                          contentPadding: EdgeInsets.only(
                              bottom: verticalBlock, left: 40, right: 40, top: verticalBlock * 6),
                          title: Text(widget.habit.summary,
                              style: TextStyle(
                                  fontSize: verticalBlock * 2.7,
                                  height: 1.4,
                                  fontWeight: FontWeight.w800,
                                  color: blue)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: verticalBlock * 2),
                          child: Text(
                            widget.habit.description,
                            style: readingText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              bottomNavigationBar: isCurrentHabit == false
                  ? HideBottomNavBar(
                      controller: controller,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (existHabit) {
                                      Platform.isAndroid
                                          ? showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        "You are already building a habit. Do you want to replace it?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        child: const Text("No"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          currentHabit.type == 'write'
                                                              ? deleteNotes()
                                                              : deleteTimer();

                                                          addHabit(context);

                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text("Yes"),
                                                      ),
                                                    ],
                                                  ))
                                          : showCupertinoDialog(
                                              context: context,
                                              builder: (context) => CupertinoAlertDialog(
                                                    title: const Text(
                                                        "You are already building a habit. Do you want to replace it?"),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        child: const Text("No"),
                                                        onPressed: () => Navigator.pop(context),
                                                      ),
                                                      CupertinoDialogAction(
                                                        child: const Text("Yes"),
                                                        onPressed: () {
                                                          currentHabit.type == 'write'
                                                              ? deleteNotes()
                                                              : deleteTimer();

                                                          addHabit(context);

                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                    } else if (widget.finishedHabit == true) {
                                      Platform.isAndroid
                                          ? showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        "You already did this habit. Do you want to do it again?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        child: const Text("No"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          addHabit(context);

                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text("Yes"),
                                                      ),
                                                    ],
                                                  ))
                                          : showCupertinoDialog(
                                              context: context,
                                              builder: (context) => CupertinoAlertDialog(
                                                    title: const Text(
                                                        "You already did this habit. Do you want to do it again?"),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        child: const Text("No"),
                                                        onPressed: () => Navigator.pop(context),
                                                      ),
                                                      CupertinoDialogAction(
                                                        child: const Text("Yes"),
                                                        onPressed: () {
                                                          addHabit(context);

                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                    } else {
                                      addHabit(context);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: verticalBlock * 3, vertical: verticalBlock * 2),
                                    decoration: BoxDecoration(
                                      color: blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'Add to your habit',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: verticalBlock * 2,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                  : null);
        } else {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
