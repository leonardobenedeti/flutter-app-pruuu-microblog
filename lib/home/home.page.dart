import 'package:Pruuu/feed/feed.page.dart';
import 'package:Pruuu/home/home.page.tabs.dart';
import 'package:Pruuu/pruuu/pruuu.widget.dart';
import 'package:Pruuu/trending/trending.page.dart';
import 'package:Pruuu/auth/screens/signin.page.dart';
import 'package:Pruuu/user/user.widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User user;

  @override
  void initState() {
    // user = new User(
    //   id: "xpto",
    //   username: "leonardobenedeti",
    //   email: "leonardobenedeti@gmail.com",
    //   nome: "Leonardo Benedeti",
    //   picturePath:
    //       "https://leonardobenedeti.github.io/assets/img/foto-perfil.png",
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openBottomSheet(PruuuWidget()),
          child: Icon(Icons.add_comment),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 16),
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
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 4),
                child: FloatingActionButton(
                  onPressed: () => _openBottomSheet(UserWidget()),
                  child: user != null && user.picturePath != null
                      ? ClipOval(
                          child: Image.network(user.picturePath),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            color: Colors.black,
                          ),
                        ),
                ),
              )
            ],
          ),
        ));
  }

  _openBottomSheet(Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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

  _changeContentBottomSheet(Widget newChild, {Function callback}) {
    callback();
    _openBottomSheet(newChild);
  }
}
