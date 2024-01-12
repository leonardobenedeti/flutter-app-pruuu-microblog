import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruuu/model/base_model.dart';
import 'package:pruuu/model/user_model.dart';

class Pruuu extends BaseModel {
  String? _documentId;
  String? authorUID;
  String? authorUsername;
  String? displayName;
  String? content;
  Timestamp? timestamp;

  Pruuu();

  @override
  String? documentId() => _documentId;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['authorUID'] = this.authorUID;
    map['content'] = this.content;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Pruuu.fromMap(DocumentSnapshot documentSnapshot, UserModel user) {
    _documentId = documentSnapshot.id;
    final data = documentSnapshot.data() as Map<String, dynamic>;
    this.authorUID = data['authorUID'];
    this.content = data['content'];
    this.timestamp = data['timestamp'];
    this.authorUsername = user.userName;
    this.displayName = user.displayName;
  }
}
