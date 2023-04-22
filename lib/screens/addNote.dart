import 'package:flutter/material.dart';
import 'package:habits/models/currentHabit_model.dart';

import 'package:habits/screens/congrats_screen.dart';
import 'package:habits/services/firestoreService.dart';
import 'package:page_transition/page_transition.dart';

import '../const.dart';

class AddNote extends StatelessWidget {
  final Function(int nrd) updateDay;
  CurrentHabit currentHabit;
  AddNote({super.key, required this.currentHabit, required this.updateDay});
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;

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
                notesCollection
                    .doc((45 - currentHabit.nrday).toString())
                    .set({'title': titleController.text, 'content': contentController.text}).whenComplete(
                        () => Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Scaffold(
                                backgroundColor: blue,
                                body: Scaffold(
                                  body: CongratsScreen(
                                    name: currentHabit.name,
                                    type: 'write',
                                    nrday: currentHabit.nrday,
                                    updateDay: updateDay,
                                  ),
                                ),
                              ),
                            )));
              },
              child: Padding(
                padding: EdgeInsets.only(right: horizontalBlock * 2),
                child: Text('Done', style: TextStyle(fontSize: verticalBlock * 2.8, color: blue)),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 5),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: verticalBlock * 1.5),
                child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: verticalBlock * 3.5))),
            Expanded(
                child: TextField(
                    controller: contentController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: currentHabit.summary, hintMaxLines: 5),
                    style: TextStyle(fontSize: verticalBlock * 2.5))),
          ],
        ),
      ),
    );
  }
}
