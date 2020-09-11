import 'package:Pruuu/models/base.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pruuu extends BaseModel {
  String _documentId;
  String authorUID;
  String authorUsername;
  String authorPicture;
  String content;
  Timestamp timestamp;

  Pruuu();

  @override
  String documentId() => _documentId;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['authorUID'] = this.authorUID;
    map['authorUsername'] = this.authorUsername;
    map['authorPicture'] = this.authorPicture;
    map['content'] = this.content;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Pruuu.fromMap(DocumentSnapshot documentSnapshot, String userPicture) {
    _documentId = documentSnapshot.documentID;
    this.authorUID = documentSnapshot.data['authorUID'];
    this.authorUsername = documentSnapshot.data['authorUsername'];
    this.authorPicture = userPicture;
    this.content = documentSnapshot.data['content'];
    this.timestamp = documentSnapshot.data['timestamp'];
  }
}
