import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PictureRepository {
  static String bucket = "gs://pruuu-214a1.appspot.com";
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: bucket);

  Future<String> pathPicture(String uid) async {
    String url = "$bucket/users/$uid.png";
    StorageReference storageRef = await _storage.getReferenceFromUrl(url);
    return await storageRef.getDownloadURL();
  }

  Future<String> uploadPicture(String uid, File file) async {
    String filePath = 'users/$uid.png';

    StorageUploadTask uploadTask = _storage.ref().child(filePath).putFile(file);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }
}
