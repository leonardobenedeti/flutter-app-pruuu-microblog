import 'dart:async';

import 'package:Pruuu/model/pruuu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PruuuRepository {
  final _firestoreInstance = Firestore.instance;

  Future<bool> pruuublish(Pruuu pruuu) async {
    var documentReference =
        await _firestoreInstance.collection('feed').add(pruuu.toMap());
    return documentReference != null;
  }

  Future<void> removePruuu(Pruuu pruuu) async {
    await _firestoreInstance
        .collection('feed')
        .document(pruuu.documentId())
        .delete();
  }
}
