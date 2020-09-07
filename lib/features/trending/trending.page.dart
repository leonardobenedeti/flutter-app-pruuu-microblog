import 'package:Pruuu/models/trending.model.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  List<Trending> trendings = [];

  Trending defaultTrending = new Trending(
    id: "tr2",
    hashtag: "#COVID19",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non nunc vitae tellus molestie eleifend. Praesent feugiat sapien erat.",
  );

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: ListView.builder(
          itemCount: trendings.length,
          padding: EdgeInsets.only(bottom: 70),
          itemBuilder: _buildTrending),
    );
  }

  Widget _buildTrending(BuildContext context, int position) {
    Trending trending = trendings[position];
    bool last = position == (trendings.length - 1);

    return trending.picture != null
        ? Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.network(
                    trending.picture,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        end: const Alignment(0.0, -1),
                        begin: const Alignment(0.0, 0.4),
                        colors: <Color>[
                          const Color(0x8A000000),
                          Colors.black12.withOpacity(0.0)
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      trending.hashtag,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trending.hashtag,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    trending.description,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                ),
                if (!last) ...[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    height: .5,
                    color: Colors.black,
                  )
                ]
              ],
            ),
          );
  }
}
