import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference chaptersCollection = _db.collection('chapters');
final CollectionReference habitsCollection = _db.collection('habits');
final CollectionReference categoriesCollection = _db.collection('habits_categories');
final CollectionReference aboutCollection = _db.collection('aboutTheApp');
CollectionReference finishedHabitsCollection = _db.collection("finishedHabits");
CollectionReference notesCollection =
    _db.collection('currentHabit').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes');
final CollectionReference currentHabitCollection = _db.collection('currentHabit');
final currentHabitUserRef =
    _db.collection('currentHabit').where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

class FirestoreService {
  static Stream<QuerySnapshot> getHabitsByType(int id) {
    return habitsCollection.where('id', isEqualTo: id).snapshots();
  }

  static Stream<QuerySnapshot> getHabitById(int id) {
    return habitsCollection.where('id', isEqualTo: id).snapshots();
  }

  static Stream<QuerySnapshot> getFinishedHabit() {
    return _db
        .collection('finishedHabits')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot> getCurrentHabit() {
    return currentHabitUserRef.snapshots();
  }

  static Stream<QuerySnapshot> getSubchapters(int screenIndex) {
    return chaptersCollection.doc(screenIndex.toString()).collection('subchapters').snapshots();
  }
}
