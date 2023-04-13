import 'package:cloud_firestore/cloud_firestore.dart';

class Subchapter {
  final String title;
  final String description;

  Subchapter({
    required this.title,
    required this.description,
  });

  factory Subchapter.fromJSON(DocumentSnapshot doc) {
    return Subchapter(
      title: doc['title'],
      description: doc['description'],
    );
  }
}
