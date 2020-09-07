import 'package:flutter/foundation.dart';

class Trending {
  String id;
  String hashtag;
  String description;
  String picture;

  Trending({
    @required this.id,
    @required this.hashtag,
    @required this.description,
    this.picture,
  });
}
