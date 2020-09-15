import 'package:Pruuu/models/pruuu.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedRepository {
  final _firestoreInstance = Firestore.instance;

  Future<List<Pruuu>> fetchFeed() async {
    return await _firestoreInstance
        .collection('feed')
        .orderBy('timestamp', descending: true)
        .getDocuments()
        .then((feedQuery) {
      return feedQuery.documents.map((doc) {
        // var path = await pathPicture(doc['authorUID']);
        return Pruuu.fromMap(doc, "path");
      }).toList();
    });
  }
}
