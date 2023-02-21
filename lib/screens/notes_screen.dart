import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/screens/habit_screen.dart';
import '../const.dart';
import 'addNote.dart';
import 'editNote.dart';
import 'home_screen.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final now = DateTime.now();
  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  final refh = FirebaseFirestore.instance
      .collection('habit')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email);

  CollectionReference refn = FirebaseFirestore.instance
      .collection('habit')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('notes');

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

  Future<void> deleteHabit(BuildContext context) async {
    Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                      "Are you sure you want to stop building this habit"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: delete,
                      child: const Text("Yes"),
                    ),
                  ],
                ))
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: const Text(
                      "Are you sure you want to stop building this habit"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("No"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: const Text("Yes"),
                      onPressed: () {
                        delete();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
  }

  Future<void> stopHabit(BuildContext context) async {
    Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                      "You missed at least a day of your habit, so you have to start over"),
                  actions: [
                    TextButton(
                      onPressed: delete,
                      child: const Text("Ok"),
                    ),
                  ],
                ))
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: const Text(
                      "You missed at least a day of your habit, so you have to start over"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("OK"),
                      onPressed: () {
                        delete();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: refh.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        DateTime time = DateTime.parse(
                            snapshot.data!.docs[0]['time'].toDate().toString());
                        final initialDay =
                            DateTime(time.year, time.month, time.day);
                        final lastDay =
                            DateTime(time.year, time.month, time.day + 45);
                        String name = snapshot.data!.docs[0]['name'];
                        String type = snapshot.data!.docs[0]['type'];
                        String description =
                            snapshot.data!.docs[0]['description'];
                        String content = snapshot.data!.docs[0]['summary'];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalBlock * 4,
                              horizontal: horizontalBlock * 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: horizontalBlock * 50,
                                    child: Text(snapshot.data!.docs[0]['name'],
                                        style: TextStyle(
                                            fontSize: verticalBlock * 3,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  IconButton(
                                      onPressed: () => deleteHabit(context),
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        size: verticalBlock * 4.5,
                                      ))
                                ],
                              ),
                              StreamBuilder(
                                  stream: refn.snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      final today = DateTime(
                                          time.year,
                                          time.month,
                                          time.day +
                                              snapshot.data!.docs.length);

                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: verticalBlock,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                child: Text('About the habit',
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          verticalBlock * 2.2,
                                                    )),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HabitScreen(
                                                              index: 4,
                                                              summary: content,
                                                              description:
                                                                  description,
                                                              name: name,
                                                              type: type,
                                                            )),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                width: verticalBlock * 6,
                                                height: verticalBlock * 6,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    CircularProgressIndicator(
                                                        strokeWidth: 3.0,
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                blue),
                                                        value: snapshot.data!
                                                                .docs.length /
                                                            45,
                                                        backgroundColor:
                                                            const Color(
                                                                0xffD8D7D7)),
                                                    Center(
                                                      child: Text(
                                                          '${(snapshot.data!.docs.length * 100.00 / 45).round()}%'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: verticalBlock * 6,
                                          ),
                                          Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: today ==
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day +
                                                                      1) ||
                                                          lastDay == today
                                                      ? () {}
                                                      : today ==
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day)
                                                          ? () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => AddNote(
                                                                        delete:
                                                                            delete,
                                                                        content:
                                                                            content,
                                                                        nrd: snapshot
                                                                            .data!
                                                                            .docs
                                                                            .length)),
                                                              );
                                                            }
                                                          : () => stopHabit(
                                                              context),
                                                  child: Container(
                                                    height: verticalBlock * 20,
                                                    width: horizontalBlock * 80,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        containerShadow
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                      child: Image.asset(
                                                        'assets/images/img${snapshot.data!.docs.length % 3}.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: horizontalBlock * 7,
                                                      right:
                                                          horizontalBlock * 7),
                                                  child: Text(
                                                      today ==
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day + 1)
                                                          ? 'Wait until tomorrow'
                                                          : lastDay == today
                                                              ? 'You have finished building your habit. Start a new one!'
                                                              : 'Start Day ${snapshot.data!.docs.length + 1}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize:
                                                              verticalBlock *
                                                                  3)),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: verticalBlock * 5,
                                          ),
                                          ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              padding:
                                                  EdgeInsets.all(verticalBlock),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          verticalBlock * 2.3),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditNote(
                                                                          content:
                                                                              content,
                                                                          docToEdit: snapshot
                                                                              .data!
                                                                              .docs[index],
                                                                        )),
                                                          );
                                                        },
                                                        child: ListTile(
                                                          dense: true,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0.0,
                                                                  right: 0.0),
                                                          title: Text(
                                                              'Day ${snapshot.data!.docs.length - index}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      verticalBlock *
                                                                          3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          subtitle: Padding(
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    verticalBlock *
                                                                        1.5,
                                                                bottom:
                                                                    verticalBlock *
                                                                        2.3),
                                                            child: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ['title'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        verticalBlock *
                                                                            2.3)),
                                                          ),
                                                          leading: Icon(
                                                            Icons
                                                                .check_circle_outline_outlined,
                                                            color: Colors.black,
                                                            size:
                                                                verticalBlock *
                                                                    4.5,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              horizontalBlock *
                                                                  14,
                                                        ),
                                                        child: Container(
                                                          height: 0.7,
                                                          width:
                                                              horizontalBlock *
                                                                  80,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      );
                                    }

                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }))));
  }
}
