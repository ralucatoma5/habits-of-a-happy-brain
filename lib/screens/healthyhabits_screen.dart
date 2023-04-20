import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habits/const.dart';
import 'package:habits/widgets/habit_gridview.dart';

class HealthyHabits extends StatefulWidget {
  const HealthyHabits({super.key});

  @override
  State<HealthyHabits> createState() => _HealthyHabitsState();
}

class _HealthyHabitsState extends State<HealthyHabits> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  late TabController _tabController;
  static List<Tab> myTabs = <Tab>[
    const Tab(
      child: Text(
        'Dopamine',
      ),
    ),
    const Tab(
      child: Text(
        'Endorphin',
      ),
    ),
    const Tab(
      child: Text(
        'Oxytocin',
      ),
    ),
    const Tab(
      child: Text(
        'Serotonin',
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  centerTitle: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(verticalBlock * 10),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalBlock * 5, vertical: verticalBlock * 1),
                      child: TabBar(
                        controller: _tabController,
                        tabs: myTabs,
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        unselectedLabelColor: Color.fromARGB(255, 175, 174, 174),
                        labelColor: blue,
                        labelStyle: TextStyle(fontSize: verticalBlock * 2.2, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: TextStyle(fontSize: verticalBlock * 2),
                        labelPadding: const EdgeInsets.only(right: 35),
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(top: verticalBlock * 2),
                    child: Text('New Habits for Each Happy Chemical',
                        style: TextStyle(
                            color: blue, fontSize: verticalBlock * 3.8, fontWeight: FontWeight.w700)),
                  )),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              HabitTypeGridView(id: 'Dopamine', controller: controller),
              HabitTypeGridView(id: 'Endorphin', controller: controller),
              HabitTypeGridView(id: 'Oxytocin', controller: controller),
              HabitTypeGridView(id: 'Serotonin', controller: controller),
            ],
          )),
    );
  }
}
