import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> deleteNotes() async {
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

Future<void> startOverNotes() async {
  final collectionhabit = FirebaseFirestore.instance
      .collection('habit')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('notes');
  var snapshots = await collectionhabit.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('habit');
    _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'nrday': 0, 'time': DateTime.now()});
  }
}

Future<void> startOverTimer() async {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('habit');
  _collectionRef
      .doc(FirebaseAuth.instance.currentUser!.email)
      .update({'nrday': 0, 'time': DateTime.now()});
}

Future<void> deleteTimer() async {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('habit');
  _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).delete();
}

Future<void> deleteHabit(BuildContext context, String type) async {
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
                    onPressed: () =>
                        type == 'notes' ? deleteNotes() : deleteTimer(),
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
                title: const Text(
                    "You missed at least a day of your habit, so you have to start over"),
                actions: [
                  TextButton(
                    onPressed: () =>
                        type == 'notes' ? startOverNotes() : startOverTimer(),
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
                      type == 'notes' ? startOverNotes() : startOverTimer();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
}
