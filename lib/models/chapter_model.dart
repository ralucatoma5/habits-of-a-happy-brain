import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/models/subchapter_model.dart';

class Chapter {
  final String imageUrl;
  final String name;
  final String summary;
  //final List<Subchapter> subChapters;

  Chapter({
    required this.imageUrl,
    required this.name,
    required this.summary,
    // required this.subChapters,
  });

  factory Chapter.fromJSON(DocumentSnapshot doc) {
    return Chapter(
      name: doc['name'],
      imageUrl: doc['img'],
      summary: doc['summary'],
      /* subChapters: List<Subchapter>.from(
       doc['subchapters'].map((subchapter) => Subchapter.fromJSON(subchapter)),
      ),*/
    );
  }
}
