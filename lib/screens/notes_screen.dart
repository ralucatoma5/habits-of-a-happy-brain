import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/models/currentHabit_model.dart';
import 'package:habits/models/habit_model.dart';
import 'package:habits/screens/habit_screen.dart';
import 'package:habits/services/firestoreService.dart';

import '../habitFunctions.dart';
import 'addNote.dart';
import 'editNote.dart';
import 'bottomNavBar.dart';

class NotesScreen extends StatefulWidget {
  CurrentHabit currentHabit;

  NotesScreen({super.key, required this.currentHabit});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final now = DateTime.now();
  final verticalBlock = SizeConfig.safeBlockVertical!;

  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  Future updateDay(int nrday) async {
    final collectionRef = FirebaseFirestore.instance.collection('habit');
    return collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({'nrday': nrday});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.symmetric(vertical: verticalBlock * 5, horizontal: horizontalBlock * 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: horizontalBlock * 50,
                child: Text(widget.currentHabit.name,
                    style: TextStyle(
                        fontSize: verticalBlock * 3.3, color: Colors.black, fontWeight: FontWeight.w700)),
              ),
              IconButton(
                  onPressed: () => deleteHabit(context, 'notes'),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: verticalBlock * 4.5,
                  ))
            ],
          ),
          StreamBuilder(
              stream: notesCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final today = DateTime(widget.currentHabit.time.year, widget.currentHabit.time.month,
                      widget.currentHabit.time.day + widget.currentHabit.nrday);

                  return Column(
                    children: [
                      SizedBox(
                        height: verticalBlock,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text('About the habit',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: verticalBlock * 2.2,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HabitScreen(
                                          index: 4,
                                          habit: Habit(
                                              name: widget.currentHabit.name,
                                              description: widget.currentHabit.description,
                                              summary: widget.currentHabit.summary,
                                              type: widget.currentHabit.type,
                                              id: widget.currentHabit.id),
                                          finishedHabit: false,
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
                                    valueColor: AlwaysStoppedAnimation(blue),
                                    value: snapshot.data!.docs.length / 45,
                                    backgroundColor: const Color(0xffD8D7D7)),
                                Center(
                                  child: Text('${(widget.currentHabit.nrday * 100.00 / 45).round()}%'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: verticalBlock * 6,
                      ),
                      Stack(alignment: Alignment.center, children: [
                        GestureDetector(
                          onTap: today == DateTime(now.year, now.month, now.day + 1)
                              ? () {}
                              : today == DateTime(now.year, now.month, now.day)
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddNote(
                                                updateDay: updateDay, currentHabit: widget.currentHabit)),
                                      );
                                    }
                                  : () => startOverHabit(context, 'notes'),
                          child: Container(
                            height: verticalBlock * 20,
                            width: horizontalBlock * 80,
                            decoration: BoxDecoration(
                              boxShadow: [containerShadow],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                              child: Image.asset(
                                'assets/images/img${widget.currentHabit.nrday % 3}.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: horizontalBlock * 7, right: horizontalBlock * 7),
                          child: Text(
                              today == DateTime(now.year, now.month, now.day + 1)
                                  ? 'Wait until tomorrow'
                                  : 'Start Day ${widget.currentHabit.nrday + 1}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: verticalBlock * 3)),
                        ),
                      ]),
                      SizedBox(
                        height: verticalBlock * 5,
                      ),
                      ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          padding: EdgeInsets.all(verticalBlock),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: verticalBlock * 2.3),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditNote(
                                                  content: widget.currentHabit.summary,
                                                  docToEdit: snapshot.data!.docs[index],
                                                )),
                                      );
                                    },
                                    child: ListTile(
                                      dense: true,
                                      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                                      title: Text('Day ${snapshot.data!.docs.length - index}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: verticalBlock * 3,
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Padding(
                                        padding: EdgeInsets.only(
                                            top: verticalBlock * 1.5, bottom: verticalBlock * 2.3),
                                        child: Text(snapshot.data!.docs[index]['title'],
                                            style: TextStyle(fontSize: verticalBlock * 2.3)),
                                      ),
                                      leading: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.black,
                                        size: verticalBlock * 4.5,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: horizontalBlock * 14,
                                    ),
                                    child: Container(
                                      height: 0.7,
                                      width: horizontalBlock * 80,
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
    ))));
  }
}
