import 'package:Pruuu/models/base.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends BaseModel {
  String _documentId;
  String userName;
  String displayName;
  String profilePicture;

  User();

  @override
  String documentId() => _documentId;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['userName'] = this.userName;
    map['displayName'] = this.displayName;
    map['profilePicture'] = this.profilePicture;
    return map;
  }

  User.fromMap(DocumentSnapshot documentSnapshot) {
    _documentId = documentSnapshot.documentID;
    this.userName = documentSnapshot.data['userName'];
    this.displayName = documentSnapshot.data['displayName'];
    this.profilePicture = documentSnapshot.data['profilePicture'];
  }
}
