import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference chaptersCollection = _db.collection('chapters');
final CollectionReference habitsCollection = _db.collection('habits');
final CollectionReference categoriesCollection = _db.collection('habits_categories');
final CollectionReference aboutCollection = _db.collection('aboutTheApp');

class FirestoreService {
  static Stream<QuerySnapshot> getHabitsByType(int id) {
    return habitsCollection.where('id', isEqualTo: id).snapshots();
  }

  static Stream<QuerySnapshot> getHabitById(int id) {
    return habitsCollection.where('id', isEqualTo: id).snapshots();
  }

  static Stream<QuerySnapshot> getFinishedHabit() {
    return FirebaseFirestore.instance
        .collection('finishedHabits')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  static Stream<QuerySnapshot> getCurrentHabit() {
    return FirebaseFirestore.instance
        .collection('habit')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  static Stream<QuerySnapshot> getSubchapters(int screenIndex) {
    return chaptersCollection.doc(screenIndex.toString()).collection('subchapters').snapshots();
  }
}
