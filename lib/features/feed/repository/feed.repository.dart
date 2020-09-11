import 'package:Pruuu/models/pruuu.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FeedRepository {
  final _firestoreInstance = Firestore.instance;

  Future<List<Pruuu>> fetchFeed() async {
    return await _firestoreInstance
        .collection('feed')
        .orderBy('timestamp')
        .getDocuments()
        .then((feedQuery) {
      return feedQuery.documents.map((doc) {
        // var path = await pathPicture(doc['authorUID']);
        return Pruuu.fromMap(doc, "path");
      }).toList();
    });
  }

  Future<String> fetchPicture(String uid) async {
    String bucket = "gs://pruuu-214a1.appspot.com";
    final FirebaseStorage _storage = FirebaseStorage(storageBucket: bucket);
    String url = "$bucket/users/$uid.png";
    StorageReference storageRef = await _storage.getReferenceFromUrl(url);
    return await storageRef.getDownloadURL();
  }
}
