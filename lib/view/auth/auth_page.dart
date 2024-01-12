import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/themes/theme_store.dart';
import 'package:pruuu/utils/assets.dart';
import 'package:pruuu/view/auth/signin_widget.dart';
import 'package:pruuu/view/auth/signup_widget.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MainStore mainStore = MainStore();
  late AuthViewModel authViewModel;
  late ThemeStore themeStore;

  @override
  void initState() {
    authViewModel = mainStore.authViewModel;
    themeStore = mainStore.themeStore;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Image.asset(
                    '${Assets.bannerAuth}${themeStore.themeString}${Assets.defaultExtension}',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Observer(
                    builder: (_) {
                      return new AnimatedCrossFade(
                        crossFadeState:
                            authViewModel.authPage == AuthPages.signin
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                        firstCurve: Curves.fastOutSlowIn,
                        firstChild: SignInWidget(_scaffoldKey),
                        secondChild: SignUpWidget(
                          _scaffoldKey,
                          alreadySigned:
                              authViewModel.authPage == AuthPages.signupData,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
