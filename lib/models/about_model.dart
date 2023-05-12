import 'package:cloud_firestore/cloud_firestore.dart';

class About {
  final String title;
  final String content;
  final String contentHabit;
  final String mainImg;
  final String backgroundImg;

  About({
    required this.title,
    required this.content,
    required this.contentHabit,
    required this.mainImg,
    required this.backgroundImg,
  });

  factory About.fromJSON(DocumentSnapshot doc) {
    return About(
        title: doc['title'],
        content: doc['content'],
        contentHabit: doc['contentHabit'],
        mainImg: doc['mainImg'],
        backgroundImg: doc['backgroundImg']);
  }
}
