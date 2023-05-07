import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits/services/firestoreService.dart';

Future addToFinisedHabits(String habitName) async {
  DocumentReference finishedHabitsDoc = finishedHabitsCollection.doc(FirebaseAuth.instance.currentUser!.uid);
  finishedHabitsDoc.get().then((docSnapshot) => {
        if (docSnapshot.exists)
          {
            finishedHabitsDoc.update({
              'finishedHabits': FieldValue.arrayUnion([habitName]),
              'id': FirebaseAuth.instance.currentUser!.uid
            }),
          }
        else
          {
            finishedHabitsDoc.set({
              'finishedHabits': [habitName],
              'id': FirebaseAuth.instance.currentUser!.uid
            }),
          }
      });
}

Future<void> startOverNotes() async {
  final collectionhabit = FirebaseFirestore.instance
      .collection('currentHabit')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');
  var snapshots = await collectionhabit.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('currentHabit');
    collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({'nrday': 0, 'time': DateTime.now()});
  }
}

Future<void> startOverTimer() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('currentHabit');
  collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({'nrday': 0, 'time': DateTime.now()});
}

Future<void> deleteTimer() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('currentHabit');
  collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).delete();
}

Future<void> deleteNotes() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('currentHabit');
  collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).delete();

  final collectionhabit = FirebaseFirestore.instance
      .collection('currentHabit')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');
  var snapshots = await collectionhabit.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }
}

Future<void> deleteHabit(BuildContext context, String type) async {
  Platform.isAndroid
      ? showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Are you sure you want to stop building this habit"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () => type == 'notes' ? deleteNotes() : deleteTimer(),
                    child: const Text("Yes"),
                  ),
                ],
              ))
      : showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text("Are you sure you want to stop building this habit"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("No"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: const Text("Yes"),
                    onPressed: () {
                      type == 'notes' ? deleteNotes() : deleteTimer();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
}

Future<void> startOverHabit(BuildContext context, String type) async {
  Platform.isAndroid
      ? showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("You missed at least a day of your habit, so you have to start over"),
                actions: [
                  TextButton(
                    onPressed: () => type == 'notes' ? startOverNotes() : startOverTimer(),
                    child: const Text("Ok"),
                  ),
                ],
              ))
      : showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text("You missed at least a day of your habit, so you have to start over"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("OK"),
                    onPressed: () {
                      type == 'notes' ? startOverNotes() : startOverTimer();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
}
