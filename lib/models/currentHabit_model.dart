import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentHabit {
  final String name;
  final String description;
  final String summary;
  final String type;
  final String id;
  final int nrday;
  final DateTime time;

  CurrentHabit({
    required this.name,
    required this.description,
    required this.summary,
    required this.type,
    required this.id,
    required this.nrday,
    required this.time,
  });

  factory CurrentHabit.fromJSON(DocumentSnapshot doc) {
    return CurrentHabit(
      name: doc['name'],
      description: doc['description'],
      summary: doc['summary'],
      type: doc['type'],
      id: doc['id'],
      nrday: doc['nrday'],
      time: DateTime.parse(doc['time'].toDate().toString()),
    );
  }
}
