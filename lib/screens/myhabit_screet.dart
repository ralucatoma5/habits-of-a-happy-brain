import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/models/currentHabit_model.dart';
import 'package:habits/screens/nohabit_screen.dart';
import 'package:habits/screens/notes_screen.dart';
import 'package:habits/screens/timer_screen.dart';
import 'package:habits/services/firestoreService.dart';

class MyHabitScreen extends StatelessWidget {
  MyHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: currentHabitUserRef.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError == true) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length != 0) {
                  CurrentHabit currentHabit = CurrentHabit.fromJSON(snapshot.data!.docs[0]);

                  return currentHabit.type == 'write'
                      ? NotesScreen(currentHabit: currentHabit)
                      : TimerScreen(currentHabit: currentHabit);
                } else if (snapshot.data!.docs.length == 0) {
                  return NoHabitScreen();
                }
              }

              return Center(child: CircularProgressIndicator());
            }));
  }
}
