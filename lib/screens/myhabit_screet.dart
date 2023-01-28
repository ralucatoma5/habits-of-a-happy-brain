import 'package:flutter/material.dart';

class MyHabitScreen extends StatefulWidget {
  const MyHabitScreen({Key? key}) : super(key: key);

  @override
  _MyHabitScreenState createState() => _MyHabitScreenState();
}

class _MyHabitScreenState extends State<MyHabitScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(child: Text('hirek', style: TextStyle(fontSize: 1000)));
  }
}
