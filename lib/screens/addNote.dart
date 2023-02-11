import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../const.dart';

class AddNote extends StatelessWidget {
  int ind;
  String content;
  AddNote({super.key, required this.ind, required this.content});
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
                ref.doc((45 - ind).toString()).set({
                  'title': titleController.text,
                  'content': contentController.text
                }).whenComplete(() => Navigator.pop(context));
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
