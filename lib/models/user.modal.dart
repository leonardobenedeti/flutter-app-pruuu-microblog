import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.id,
    @required this.email,
    @required this.nome,
    @required this.username,
    @required this.picturePath,
  });

  String id;
  String email;
  String nome;
  String username;
  String picturePath;
}
