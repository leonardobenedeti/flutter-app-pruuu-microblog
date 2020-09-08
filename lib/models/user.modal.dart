import 'package:flutter/foundation.dart';

class User {
  String id;
  String email;
  String nome;
  String username;
  String picturePath;

  User({
    @required this.id,
    @required this.email,
    @required this.nome,
    @required this.username,
    @required this.picturePath,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nome = json['nome'];
    username = json['username'];
    picturePath = json['picturePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['username'] = this.username;
    data['picturePath'] = this.picturePath;
    return data;
  }
}
