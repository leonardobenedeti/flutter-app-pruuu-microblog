import 'package:Pruuu/models/user.modal.dart';
import 'package:flutter/foundation.dart';

class Pruuu {
  Pruuu({
    @required this.id,
    @required this.timestamp,
    @required this.content,
    @required this.user,
  });

  String id;
  DateTime timestamp;
  String content;
  User user;
}
