import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/widgets/positionedButton.dart';

class HabitScreen extends StatelessWidget {
  final index;
  HabitScreen({Key? key, required this.index}) : super(key: key);
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  Future addToHabit() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("habit");
    return _collectionRef
        .doc()
        .collection("habit")
        .doc()
        .set({'name': 'x', 'description': 'xyz'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: verticalBlock * 23,
                width: verticalBlock * 100,
                child: Stack(alignment: Alignment.center, children: [
                  positionedButton(context),
                  Positioned(
                      top: verticalBlock * -2,
                      right: horizontalBlock * -7,
                      child: Container(
                        height: verticalBlock * 23,
                        width: verticalBlock * 23,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff006FA9)
                              .withOpacity(circleOpacity(index)),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(top: verticalBlock * 5),
                    width: horizontalBlock * 65,
                    child: Text(
                      'Take Small Steps Toward a New Goal',
                      style: TextStyle(
                          fontSize: verticalBlock * 3.5,
                          height: 1.4,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ]),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(Icons.timer_outlined,
                    color: blue, size: verticalBlock * 5),
                contentPadding: EdgeInsets.symmetric(
                    vertical: verticalBlock * 2,
                    horizontal: horizontalBlock * 7),
                title: Text('Invest 10 minutes a day in your goal',
                    style: TextStyle(
                        fontSize: verticalBlock * 2.7,
                        height: 1.4,
                        fontWeight: FontWeight.w800,
                        color: blue)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalBlock * 9,
                    vertical: verticalBlock * 2),
                child: Text(
                  'It doesn’t take much time or money to step toward a goal. Just commit ten minutes a day and you will feel momentum instead of feeling stuck. Ten minutes is not enough to move mountains, but it’s enough to approach the mountain and see it accurately. Instead of dreaming about your goal from afar, you can gather the information you need to plan realistically. Your goals might change as your information grows. You might even learn that your fantasy goal would not make you happy. Those ten-minute investments can free you from unnecessary regret and help you find a hill you can actually climb. Your ten-minute efforts can define manageable steps so you’re not just waiting for huge leaps that never come. Spend your time on concrete action. Don’t spend it fantasizing about quitting your day job or pressuring others to help you. It’s not their goal. Dig into practical realities instead. Do this faithfully for forty-five days and you will have the habit of moving forward.',
                  style: readingText,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: addToHabit,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: verticalBlock * 3,
                          vertical: verticalBlock * 3),
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Add to your habit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: verticalBlock * 2,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
