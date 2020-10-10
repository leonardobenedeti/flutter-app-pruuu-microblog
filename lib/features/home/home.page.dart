import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/feed/screens/feed.page.dart';
import 'package:Pruuu/features/home/home.page.tabs.dart';
import 'package:Pruuu/features/pruuu/screens/pruuu.widget.dart';
import 'package:Pruuu/features/trending/trending.page.dart';
import 'package:Pruuu/features/user/user.widget.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/models/user.model.dart';
import 'package:Pruuu/themes/theme.store.dart';
import 'package:Pruuu/widgets/bottomSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum TypeUserBlocChild { pruuu, userArea }

class _MyHomePageState extends State<MyHomePage> {
  AuthStore authStore = MainStore().authStore;
  ThemeStore themeStore = MainStore().themeStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _wrapUserBloc(TypeUserBlocChild.pruuu),
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
              _wrapUserBloc(TypeUserBlocChild.userArea)
            ],
          ),
        ));
  }

  _openBottomSheet(Widget child) {
    PruuuBottomSheet(
      child: child,
      context: context,
    ).show();
  }

  Widget _pruuuFAB(FirebaseUser user) {
    return FloatingActionButton(
      onPressed: () => _openBottomSheet(PruuuWidget(user: user)),
      child: Icon(
        Icons.add_comment,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _userAreaFAB(User user) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 1.5,
        ),
      ),
      margin: EdgeInsets.fromLTRB(0, 4, 16, 0),
      child: GestureDetector(
        onTap: () => _openBottomSheet(UserWidget()),
        child: user.profilePicture != null
            ? ClipOval(
                child: Image.network(
                  user.profilePicture,
                  fit: BoxFit.cover,
                ),
              )
            : ClipOval(
                child: Container(
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  color: Colors.black,
                ),
              ),
      ),
    );
  }

  Widget _wrapUserBloc(TypeUserBlocChild type) {
    return Observer(
      builder: (_) {
        if (authStore.authState == AuthState.signed) {
          return type == TypeUserBlocChild.pruuu
              ? _pruuuFAB(authStore.user)
              : _userAreaFAB(authStore.userInfo);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
