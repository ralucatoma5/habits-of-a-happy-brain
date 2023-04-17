import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/models/subchapter_model.dart';

class Chapter {
  final String imageUrl;
  final String name;
  final String summary;

  Chapter({
    required this.imageUrl,
    required this.name,
    required this.summary,
  });

  factory Chapter.fromJSON(DocumentSnapshot doc) {
    return Chapter(
      name: doc['name'],
      imageUrl: doc['img'],
      summary: doc['summary'],
    );
  }
}
