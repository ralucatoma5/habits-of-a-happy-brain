import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import 'addNote.dart';
import 'editNote.dart';
import 'home_screen.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  final refh = FirebaseFirestore.instance
      .collection('habit')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email);

  CollectionReference refn = FirebaseFirestore.instance
      .collection('habit')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('notes');

  Future<void> deleteHabit() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('habit');
    _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).delete();
    _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('notes')
        .doc()
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: refh.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalBlock * 4,
                              horizontal: horizontalBlock * 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: horizontalBlock * 50,
                                    child: Text(snapshot.data!.docs[0]['name'],
                                        style: TextStyle(
                                            fontSize: verticalBlock * 3,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  IconButton(
                                      onPressed: deleteHabit,
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        size: verticalBlock * 4.5,
                                      ))
                                ],
                              ),
                              StreamBuilder(
                                  stream: refn.snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                child: Text('About the habit',
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          verticalBlock * 2.2,
                                                    )),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen()),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                width: verticalBlock * 6,
                                                height: verticalBlock * 6,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    CircularProgressIndicator(
                                                        strokeWidth: 3.0,
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                blue),
                                                        value: snapshot.data!
                                                                .docs.length /
                                                            45,
                                                        backgroundColor:
                                                            const Color(
                                                                0xffD8D7D7)),
                                                    Center(
                                                      child: Text(
                                                          '${(snapshot.data!.docs.length * 100.00 / 45).round()}%'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: verticalBlock * 6,
                                          ),
                                          Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddNote(
                                                                  ind: snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length)),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: verticalBlock * 20,
                                                    width: horizontalBlock * 80,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        containerShadow
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                      child: Image.asset(
                                                        'assets/images/img2.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                    'Start Day ${snapshot.data!.docs.length + 1}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize:
                                                            verticalBlock *
                                                                3.5)),
                                              ]),
                                          SizedBox(
                                            height: verticalBlock * 5,
                                          ),
                                          ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              padding:
                                                  EdgeInsets.all(verticalBlock),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          verticalBlock * 2.3),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditNote(
                                                                          docToEdit: snapshot
                                                                              .data!
                                                                              .docs[index],
                                                                        )),
                                                          );
                                                        },
                                                        child: ListTile(
                                                          dense: true,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0.0,
                                                                  right: 0.0),
                                                          title: Text(
                                                              'Day ${snapshot.data!.docs.length - index}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      verticalBlock *
                                                                          3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          subtitle: Padding(
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    verticalBlock *
                                                                        1.5,
                                                                bottom:
                                                                    verticalBlock *
                                                                        2.3),
                                                            child: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ['title'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        verticalBlock *
                                                                            2.3)),
                                                          ),
                                                          leading: Icon(
                                                            Icons
                                                                .check_circle_outline_outlined,
                                                            color: Colors.black,
                                                            size:
                                                                verticalBlock *
                                                                    4.5,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              horizontalBlock *
                                                                  14,
                                                        ),
                                                        child: Container(
                                                          height: 0.7,
                                                          width:
                                                              horizontalBlock *
                                                                  80,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      );
                                    }

                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }))));
  }
}
