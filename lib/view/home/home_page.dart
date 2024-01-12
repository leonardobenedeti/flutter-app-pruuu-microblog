import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/model/user_model.dart';
import 'package:pruuu/themes/theme_store.dart';
import 'package:pruuu/utils/strings.dart';
import 'package:pruuu/view/home/home_tabs.dart';
import 'package:pruuu/view/home/screens/feed_page.dart';
import 'package:pruuu/view/home/screens/pruuu_it_widget.dart';
import 'package:pruuu/view/home/screens/trending_page.dart';
import 'package:pruuu/view/user_page.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';
import 'package:pruuu/widgets/bottom_sheet.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum TypeUserBlocChild { pruuu, userArea }

class _MyHomePageState extends State<MyHomePage> {
  AuthViewModel authViewModel = MainStore().authViewModel;
  ThemeStore themeStore = MainStore().themeStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _wrapUserBloc(TypeUserBlocChild.pruuu),
        body: SafeArea(
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                HomePageTabs(
                  tabs: [
                    new Tab(text: Strings.feed),
                    new Tab(text: Strings.trending),
                  ],
                  childTabs: [
                    FeedPage(),
                    TrendingPage(),
                  ],
                ),
                _wrapUserBloc(TypeUserBlocChild.userArea)
              ],
            ),
          ),
        ));
  }

  _openBottomSheet(Widget child, bool fullscreenDialog) {
    PruuuBottomSheet(
      child: child,
      context: context,
      fullscreenDialog: fullscreenDialog,
    ).show();
  }

  Widget _pruuuFAB(User? user) {
    return FloatingActionButton(
      onPressed: () => _openBottomSheet(PruuuWidget(user: user), false),
      child: Icon(
        Icons.add_comment,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _userAreaFAB(UserModel user) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).canvasColor,
          width: 1.5,
        ),
      ),
      margin: EdgeInsets.fromLTRB(0, 4, 16, 0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserPage(), fullscreenDialog: true),
        ),
        child: user.profilePicture!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  user.profilePicture!,
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
        if (authViewModel.authState == AuthState.signed) {
          return type == TypeUserBlocChild.pruuu
              ? _pruuuFAB(authViewModel.user)
              : _userAreaFAB(authViewModel.userInfo);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
