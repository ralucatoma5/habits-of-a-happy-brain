import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:habits/screens/congrats_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../const.dart';

class AddNote extends StatelessWidget {
  int nrd;
  final Function(int nrd) updateDay;
  String name;
  String content;
  AddNote(
      {super.key,
      required this.nrd,
      required this.content,
      required this.name,
      required this.updateDay});
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('habit')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: blue,
        ),
        elevation: 0,
        backgroundColor: Color(0xffFEFEFE),
        actions: [
          TextButton(
              onPressed: () {
                ref.doc((45 - nrd).toString()).set({
                  'title': titleController.text,
                  'content': contentController.text
                }).whenComplete(() => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: Scaffold(
                        backgroundColor: blue,
                        body: Scaffold(
                          body: CongratsScreen(
                            name: name,
                            type: 'write',
                            nrday: nrd,
                            updateDay: updateDay,
                          ),
                        ),
                      ),
                    )));
              },
              child: Padding(
                padding: EdgeInsets.only(right: horizontalBlock * 2),
                child: Text('Done',
                    style:
                        TextStyle(fontSize: verticalBlock * 2.8, color: blue)),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 5),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: verticalBlock * 1.5),
              child: Container(
                  child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: verticalBlock * 3.5))),
            ),
            Expanded(
              child: Container(
                  child: TextField(
                      controller: contentController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(hintText: content),
                      style: TextStyle(fontSize: verticalBlock * 2.5))),
            )
          ],
        ),
      ),
    );
  }
}
