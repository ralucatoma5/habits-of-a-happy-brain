import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/screens/myhabit_screet.dart';
import 'package:habits/screens/timer_screen.dart';

import '../const.dart';
import 'account.dart';
import 'notes_screen.dart';
import 'reading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final CollectionReference _referenceChapters =
      FirebaseFirestore.instance.collection('chapters');

  late Stream<QuerySnapshot> _streamChapters;
  @override
  void initState() {
    _streamChapters = _referenceChapters.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final horizonalBlock = SizeConfig.safeBlockHorizontal!;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _streamChapters,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError == true) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.connectionState == ConnectionState.active) {
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                    querySnapshot.docs;
                return currentIndex == 0
                    ? ReadingScreen(listQueryDocumentSnapshot)
                    : currentIndex == 1
                        ? MyHabitScreen()
                        : Account();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(
                Icons.menu_book,
                size: horizonalBlock * 6,
              ),
              activeIcon: Icon(
                Icons.menu_book,
                size: horizonalBlock * 8,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/habit_icon.png'),
                size: horizonalBlock * 6,
              ),
              activeIcon: ImageIcon(
                const AssetImage('assets/images/habit_icon.png'),
                size: horizonalBlock * 9,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: horizonalBlock * 6,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                size: horizonalBlock * 9,
              ),
              label: "",
            ),
          ],
        ));
  }
}
