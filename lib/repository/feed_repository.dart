import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruuu/model/pruuu_model.dart';
import 'package:pruuu/model/user_model.dart';

class FeedRepository {
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Pruuu>> fetchFeed() async {
    List<Pruuu> feed = [];

    QuerySnapshot querySnapshot = await _firestoreInstance
        .collection('feed')
        .orderBy('timestamp', descending: true)
        .get();

    for (var i = 0; querySnapshot.docs.length - 1 >= i; i++) {
      final user =
          await fetchUserDataToFeed(querySnapshot.docs[i]['authorUID']);
      Pruuu pruuu = Pruuu.fromMap(querySnapshot.docs[i], user);
      feed.add(pruuu);
    }

    return feed.toList();
  }

  Future<UserModel> fetchUserDataToFeed(String uid) async {
    return await _firestoreInstance
        .collection('users')
        .doc(uid)
        .get()
        .then((user) => UserModel.fromMap(user));
  }
}
