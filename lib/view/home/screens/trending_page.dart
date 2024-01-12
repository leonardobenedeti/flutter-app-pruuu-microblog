import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pruuu/model/trending_model.dart';
import 'package:pruuu/view_model/trendings/trendings_view_model.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final trendingsViewModel = TrendingsViewModel();

  @override
  void initState() {
    trendingsViewModel.fetchTrendings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Container(
        margin: EdgeInsets.only(top: 8),
        child: ListView.builder(
            itemCount: trendingsViewModel.trendings.length,
            padding: EdgeInsets.only(bottom: 70),
            itemBuilder: _buildTrending),
      ),
    );
  }

  Widget _buildTrending(BuildContext context, int position) {
    Trending trending = trendingsViewModel.trendings[position];
    bool last = position == (trendingsViewModel.trendings.length - 1);

    return trending.picture != null
        ? Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.network(
                    trending.picture!,
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
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(trending.description,
                      style: Theme.of(context).textTheme.headlineMedium),
                ),
                if (!last) ...[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    height: .5,
                    color: Theme.of(context).canvasColor,
                  )
                ]
              ],
            ),
          );
  }
}
