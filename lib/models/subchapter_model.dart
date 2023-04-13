import 'package:cloud_firestore/cloud_firestore.dart';

class Subchapter {
  final String title;
  final String description;
  final List<String> examples;

  Subchapter({required this.title, required this.description, required this.examples});

  factory Subchapter.fromJSON(DocumentSnapshot doc) {
    return Subchapter(
        title: doc['subchapter_title'],
        description: doc['subchapter_description'],
        examples: List<String>.from(doc['subchapter_examples']));
  }
}
