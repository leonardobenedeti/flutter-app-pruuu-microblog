import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruuu/model/pruuu_model.dart';

class PruuuRepository {
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<bool> pruuublish(Pruuu pruuu) async {
    await _firestoreInstance.collection('feed').add(pruuu.toMap());
    return true;
  }

  Future<void> removePruuu(Pruuu pruuu) async {
    await _firestoreInstance
        .collection('feed')
        .doc(pruuu.documentId())
        .delete();
  }
}
