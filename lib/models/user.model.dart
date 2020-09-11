import 'package:flutter/foundation.dart';

class User {
  String nome;
  String username;
  String picturePath;

  User({
    @required this.nome,
    @required this.username,
    @required this.picturePath,
  });

  User.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    username = json['username'];
    picturePath = json['picturePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['username'] = this.username;
    data['picturePath'] = this.picturePath;
    return data;
  }
}
