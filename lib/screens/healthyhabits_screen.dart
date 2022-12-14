import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habits/const.dart';

import 'habit_screen.dart';

class HealthyHabits extends StatelessWidget {
  HealthyHabits({Key? key}) : super(key: key);
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            toolbarHeight: verticalBlock * 10,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                Text('Dopamine',
                    style: TextStyle(
                      color: blue,
                      fontSize: verticalBlock * 3.7,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(width: horizontalBlock * 3),
                Text('Habits',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: verticalBlock * 3.7,
                      fontWeight: FontWeight.w800,
                    ))
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(15),
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20,
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HabitScreen(index: index)),
                    );
                  },
                  child: Container(
                    height: verticalBlock * 30,
                    width: horizontalBlock * 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7F7),
                      boxShadow: [containerShadow],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: verticalBlock * topPosition(index),
                            left: horizontalBlock * leftPosition(index),
                            width: horizontalBlock * 40,
                            child: Container(
                              height: verticalBlock * circleHeight(index),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff006FA9)
                                    .withOpacity(circleOpacity(index)),
                              ),
                            )),
                        Positioned(
                          top: verticalBlock * 2,
                          right: horizontalBlock * 3,
                          child: Image.asset(
                            'assets/images/write-icon.png',
                            height: verticalBlock * 5,
                          ),
                        ),
                        Positioned(
                          bottom: verticalBlock * 5,
                          left: horizontalBlock * 6,
                          child: SizedBox(
                            width: horizontalBlock * 35,
                            child: Text(
                              'Take Small Steps Toward a New Goal',
                              style: TextStyle(
                                color: blue,
                                fontSize: verticalBlock * 2.8,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(
                    1, index == 1 || index == 3 ? 1.35 : 1.55);
              }),
        ));
  }
}
