import 'package:Pruuu/models/base.model.dart';
import 'package:Pruuu/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pruuu extends BaseModel {
  String _documentId;
  String authorUID;
  String authorUsername;
  String displayName;
  String content;
  Timestamp timestamp;

  Pruuu();

  @override
  String documentId() => _documentId;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['authorUID'] = this.authorUID;
    map['content'] = this.content;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Pruuu.fromMap(DocumentSnapshot documentSnapshot, User user) {
    _documentId = documentSnapshot.documentID;
    this.authorUID = documentSnapshot.data['authorUID'];
    this.content = documentSnapshot.data['content'];
    this.timestamp = documentSnapshot.data['timestamp'];
    this.authorUsername = user.userName;
    this.displayName = user.displayName;
  }
}
