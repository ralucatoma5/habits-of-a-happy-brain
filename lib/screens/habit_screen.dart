import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../const.dart';

class HabitScreen extends StatelessWidget {
  final index;
  final String summary;
  final String description;
  final String name;
  final String type;
  final bool abtscrn;
  HabitScreen(
      {Key? key,
      required this.index,
      required this.summary,
      required this.description,
      required this.name,
      required this.type,
      required this.abtscrn})
      : super(key: key);

  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  var now = DateTime.now();
  var formatter = DateFormat('dd');

  Future addToHabit() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("habit");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).set({
      'name': name,
      'description': description,
      'summary': summary,
      'type': type,
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
          backgroundColor: Colors.white,
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
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: verticalBlock * 23,
                width: verticalBlock * 100,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                      top: SizeConfig.safeBlockVertical! * 6.5,
                      left: SizeConfig.safeBlockHorizontal! * 5,
                      child: IconButton(
                        icon: Icon(
                          Icons.adaptive.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Positioned(
                      top: verticalBlock * -2,
                      right: horizontalBlock * -7,
                      child: Container(
                        height: verticalBlock * 23,
                        width: verticalBlock * 23,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor(index).withOpacity(0.75),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(top: verticalBlock * 5),
                    width: horizontalBlock * 65,
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: verticalBlock * 3.5,
                          height: 1.4,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ]),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: type == 'write'
                    ? Image.asset(
                        'assets/images/write-blueIcon.png',
                        height: verticalBlock * 5,
                      )
                    : Icon(Icons.timer_outlined,
                        color: blue, size: verticalBlock * 5),
                contentPadding: EdgeInsets.symmetric(
                    vertical: verticalBlock * 2,
                    horizontal: horizontalBlock * 7),
                title: Text(summary,
                    style: TextStyle(
                        fontSize: verticalBlock * 2.7,
                        height: 1.4,
                        fontWeight: FontWeight.w800,
                        color: blue)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalBlock * 9,
                    vertical: verticalBlock * 2),
                child: Text(
                  description,
                  style: readingText,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: abtscrn == false
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
                        onTap: () => addHabit(context),
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
  }
}
