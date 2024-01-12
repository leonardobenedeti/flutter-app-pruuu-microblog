import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruuu/model/base_model.dart';

class UserModel extends BaseModel {
  String? _documentId;
  String? userName;
  String? displayName;
  String? profilePicture;

  UserModel();

  @override
  String? documentId() => _documentId;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['userName'] = this.userName;
    map['displayName'] = this.displayName;
    map['profilePicture'] = this.profilePicture;
    return map;
  }

  UserModel.fromMap(DocumentSnapshot documentSnapshot) {
    _documentId = documentSnapshot.id;
    final data = documentSnapshot.data() as Map<String, dynamic>;
    this.userName = data['userName'];
    this.displayName = data['displayName'];
    this.profilePicture = data['profilePicture'];
  }
}
