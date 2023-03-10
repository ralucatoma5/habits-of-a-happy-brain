import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habits/screens/nohabit_screen.dart';
import 'package:habits/screens/notes_screen.dart';
import 'package:habits/screens/timer_screen.dart';

class MyHabitScreen extends StatelessWidget {
  MyHabitScreen({super.key});
  final refh = FirebaseFirestore.instance
      .collection('habit')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: refh.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError == true) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length != 0) {
                  return snapshot.data!.docs[0]['type'] == 'write'
                      ? NotesScreen()
                      : TimerScreen();
                } else if (snapshot.data!.docs.length == 0) {
                  return NoHabitScreen();
                }
              }

              return Center(child: CircularProgressIndicator());
            }));
  }
}
