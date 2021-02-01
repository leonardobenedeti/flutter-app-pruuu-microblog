import 'package:Pruuu/model/pruuu_model.dart';
import 'package:Pruuu/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedRepository {
  final _firestoreInstance = Firestore.instance;

  Future<List<Pruuu>> fetchFeed() async {
    List<Pruuu> feed = [];

    QuerySnapshot querySnapshot = await _firestoreInstance
        .collection('feed')
        .orderBy('timestamp', descending: true)
        .getDocuments();

    for (var i = 0; querySnapshot.documents.length - 1 >= i; i++) {
      User user = await fetchUserDataToFeed(
          querySnapshot.documents[i].data['authorUID']);
      Pruuu pruuu = Pruuu.fromMap(querySnapshot.documents[i], user);
      feed.add(pruuu);
    }

    return feed.toList();
  }

  Future<User> fetchUserDataToFeed(String uid) async {
    return await _firestoreInstance
        .collection('users')
        .document(uid)
        .get()
        .then((user) => User.fromMap(user));
  }
}
