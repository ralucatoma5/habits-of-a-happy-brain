import 'package:flutter/material.dart';
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
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0.8,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(verticalBlock * 10),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalBlock * 6, vertical: verticalBlock * 1),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: blue,
                      ),
                      controller: _tabController,
                      tabs: myTabs,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      unselectedLabelColor: const Color.fromARGB(255, 175, 174, 174),
                      labelColor: Colors.white,
                      labelStyle: TextStyle(fontSize: verticalBlock * 2.4, fontWeight: FontWeight.w700),
                      unselectedLabelStyle: TextStyle(fontSize: verticalBlock * 2.2),
                      labelPadding: EdgeInsets.symmetric(horizontal: horizontalBlock * 4.5),
                    ),
                  ),
                ),
                centerTitle: false,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 2),
                  child: Text(
                    'New Habits for\nEach Happy Chemical',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: verticalBlock * 3.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                toolbarHeight: verticalBlock * 13,
              ),
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
