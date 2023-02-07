import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';

class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNote({super.key, required this.docToEdit});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    Map<String, dynamic> data =
        widget.docToEdit.data()! as Map<String, dynamic>;
    titleController = TextEditingController(text: data['title']);
    contentController = TextEditingController(text: data['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: blue,
        ),
        elevation: 0,
        backgroundColor: const Color(0xffFEFEFE),
        actions: [
          TextButton(
              onPressed: () {
                widget.docToEdit.reference.update({
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
              child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: verticalBlock * 3.5)),
            ),
            Expanded(
              child: TextField(
                  controller: contentController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Content'),
                  style: TextStyle(fontSize: verticalBlock * 2.5)),
            )
          ],
        ),
      ),
    );
  }
}
