import 'package:flutter/material.dart';
import 'package:habits/screens/healthyhabits_screen.dart';
import 'package:habits/screens/myhabit_screet.dart';

import '../const.dart';
import '../widgets/hideButtomNavBar_widget.dart';
import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final horizontalBlock = SizeConfig.safeBlockHorizontal!;
    return Scaffold(
        body: currentIndex == 0
            ? ReadingScreen(controller: controller)
            : currentIndex == 1
                ? MyHabitScreen()
                : const HealthyHabits(),
        bottomNavigationBar: HideBottomNavBar(
          controller: controller,
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 10,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            backgroundColor: Colors.white,
            selectedFontSize: 0,
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/book-icon.png'),
                  size: horizontalBlock * 5.5,
                ),
                activeIcon: ImageIcon(
                  const AssetImage('assets/book-icon.png'),
                  size: horizontalBlock * 7.5,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/heart-icon.png'),
                  size: horizontalBlock * 5.5,
                ),
                activeIcon: ImageIcon(
                  const AssetImage('assets/heart-icon.png'),
                  size: horizontalBlock * 7.5,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/habit_icon.png'),
                  size: horizontalBlock * 7,
                ),
                activeIcon: ImageIcon(
                  const AssetImage('assets/habit_icon.png'),
                  size: horizontalBlock * 9,
                ),
                label: "",
              ),
            ],
          ),
        ));
  }
}
