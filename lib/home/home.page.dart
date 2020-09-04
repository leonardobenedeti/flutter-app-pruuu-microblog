import 'package:Pruuu/feed/feed.page.dart';
import 'package:Pruuu/home/home.page.tabs.dart';
import 'package:Pruuu/pruuu/pruuu.widget.dart';
import 'package:Pruuu/trending/trending.page.dart';
import 'package:Pruuu/user/user.component.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openBottomSheet(PruuuWidget()),
          child: Icon(Icons.add_comment),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              HomePageTabs(
                tabs: [
                  new Tab(text: "Feed"),
                  new Tab(text: "Trending"),
                ],
                childTabs: [
                  FeedPage(),
                  TrendingPage(),
                ],
              ),
              FloatingActionButton(
                onPressed: () => _openBottomSheet(UserWidget()),
                child: Icon(Icons.person_outline),
              )
            ],
          ),
        ));
  }

  _openBottomSheet(Widget child) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return child;
      },
    );
  }
}
