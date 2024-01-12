import 'dart:async';

import 'package:pruuu/model/trending_model.dart';

class TrendingsRepository {
  Trending defaultTrending = new Trending(
    id: "tr2",
    hashtag: "#COVID19",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non nunc vitae tellus molestie eleifend. Praesent feugiat sapien erat.",
  );

  List<Trending> trendings = [];

  Future<List<Trending>> fetchTrendings() async {
    trendings.addAll([
      new Trending(
        id: "tr1",
        hashtag: "#Séries",
        description: "Descubra o que estão comentando das melhores séries",
        picture:
            "https://cloud.estacaonerd.com/wp-content/uploads/2019/12/24151840/3627282.jpg-r_640_360-f_jpg-q_x-xxyxx.jpg",
      ),
      defaultTrending,
      defaultTrending,
      defaultTrending,
      defaultTrending,
      defaultTrending,
      defaultTrending,
      defaultTrending,
      defaultTrending,
      defaultTrending,
    ]);
    return trendings;
  }
}
