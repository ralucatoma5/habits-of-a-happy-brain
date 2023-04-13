import 'package:cloud_firestore/cloud_firestore.dart';

class HabitType {
  final String name;
  final int id;

  HabitType({
    required this.name,
    required this.id,
  });

  factory HabitType.fromJSON(DocumentSnapshot doc) {
    return HabitType(
      name: doc['name'],
      id: doc['id'],
    );
  }
}
