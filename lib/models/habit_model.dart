import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String name;
  final String description;
  final String summary;
  final String type;
  final String id;

  Habit({
    required this.name,
    required this.description,
    required this.summary,
    required this.type,
    required this.id,
  });

  factory Habit.fromJSON(DocumentSnapshot doc) {
    return Habit(
      name: doc['name'],
      description: doc['description'],
      summary: doc['summary'],
      type: doc['type'],
      id: doc['id'],
    );
  }
}
