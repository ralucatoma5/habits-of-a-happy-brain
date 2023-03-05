import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../const.dart';

class HabitScreen extends StatefulWidget {
  final index;
  final String summary;
  final String description;
  final String name;
  final String type;

  HabitScreen(
      {Key? key,
      required this.index,
      required this.summary,
      required this.description,
      required this.name,
      required this.type})
      : super(key: key);

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  var now = DateTime.now();

  var formatter = DateFormat('dd');

  bool currentHabit = false;

  bool existHabit = false;

  Future addToHabit() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("habit");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).set({
      'name': widget.name,
      'description': widget.description,
      'summary': widget.summary,
      'type': widget.type,
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

  Future<void> delete() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('habit');
    _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).delete();

    final collectionhabit = FirebaseFirestore.instance
        .collection('habit')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('notes');
    var snapshots = await collectionhabit.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> deleteTimerHabit() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('habit');
    collectionRef.doc(FirebaseAuth.instance.currentUser!.email).delete();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('habit')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final querySnaphost = snapshot.data;
          if (querySnaphost!.docs.isNotEmpty) {
            // document exists
            currentHabit = snapshot.data!.docs[0]['name'] == widget.name;
            existHabit = true;
          } else {
            // document does not exist
          }
          return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: verticalBlock * 23,
                      width: verticalBlock * 100,
                      child: Stack(alignment: Alignment.center, children: [
                        Positioned(
                            top: SizeConfig.safeBlockVertical! * 7,
                            left: SizeConfig.safeBlockHorizontal! * 5,
                            child: IconButton(
                              icon: Icon(
                                Icons.adaptive.arrow_back,
                                size: verticalBlock * 3.5,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        Positioned(
                            top: SizeConfig.safeBlockVertical! * 7,
                            left: SizeConfig.safeBlockHorizontal! * 12,
                            child: Container(
                              width: horizontalBlock * 65,
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: verticalBlock * 3.5,
                                    height: 1.4,
                                    fontWeight: FontWeight.w800),
                              ),
                            )),
                        Positioned(
                            top: verticalBlock * -2,
                            right: horizontalBlock * -7,
                            child: Container(
                              height: verticalBlock * 23,
                              width: verticalBlock * 23,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    circleColor(widget.index).withOpacity(0.75),
                              ),
                            )),
                      ]),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: widget.type == 'write'
                          ? Image.asset(
                              'assets/images/write-blueIcon.png',
                              height: verticalBlock * 5,
                            )
                          : Icon(Icons.timer_outlined,
                              color: blue, size: verticalBlock * 5),
                      contentPadding: EdgeInsets.only(
                          bottom: verticalBlock * 2, left: 40, right: 40),
                      title: Text(widget.summary,
                          style: TextStyle(
                              fontSize: verticalBlock * 2.7,
                              height: 1.4,
                              fontWeight: FontWeight.w800,
                              color: blue)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: verticalBlock * 2),
                      child: Text(
                        widget.description,
                        style: readingText,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: currentHabit == false
                  ? Container(
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
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("No"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      snapshot.data!.docs[0]
                                                                  ['type'] ==
                                                              'write'
                                                          ? delete()
                                                          : deleteTimerHabit();
                                                      addHabit(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                ],
                                              ))
                                      : showCupertinoDialog(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoAlertDialog(
                                                title: const Text(
                                                    "You are already building a habit. Do you want to replace it?"),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: const Text("No"),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: const Text("Yes"),
                                                    onPressed: () {
                                                      snapshot.data!.docs[0]
                                                                  ['type'] ==
                                                              'write'
                                                          ? delete()
                                                          : deleteTimerHabit();
                                                      setState(() {
                                                        addHabit(context);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ));
                                } else {
                                  setState(() {
                                    addHabit(context);
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: verticalBlock * 3,
                                    vertical: verticalBlock * 2),
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
                      ))
                  : null);
        } else {
          // Show a loading widget
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
