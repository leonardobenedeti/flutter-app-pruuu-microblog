import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:Pruuu/features/feed/feed.page.dart';
import 'package:Pruuu/features/home/home.page.tabs.dart';
import 'package:Pruuu/features/pruuu/pruuu.widget.dart';
import 'package:Pruuu/features/trending/trending.page.dart';
import 'package:Pruuu/features/user/user.widget.dart';
import 'package:Pruuu/models/user.modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum TypeUserBlocChild { pruuu, userArea }

class _MyHomePageState extends State<MyHomePage> {
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
              Container(
                  height: 40,
                  margin: EdgeInsets.only(top: 4),
                  child: _wrapUserBloc(TypeUserBlocChild.userArea))
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

  Widget _pruuuFAB(FirebaseUser user) {
    return FloatingActionButton(
      onPressed: () => _openBottomSheet(PruuuWidget()),
      child: Icon(Icons.add_comment),
    );
  }

  Widget _userAreaFAB(FirebaseUser user) {
    return FloatingActionButton(
      onPressed: () => _openBottomSheet(UserWidget()),
      child: user != null && user.photoUrl != null
          ? ClipOval(
              child: Image.network(user.photoUrl),
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
    );
  }

  Widget _wrapUserBloc(TypeUserBlocChild type) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()..add(StartApp()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSigned) {
            return type == TypeUserBlocChild.pruuu
                ? _pruuuFAB(state.user)
                : _userAreaFAB(state.user);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
