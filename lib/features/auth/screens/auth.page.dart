import 'package:Pruuu/features/auth/screens/signin.page.dart';
import 'package:Pruuu/features/auth/screens/signup.page.dart';
import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/themes/theme.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MainStore mainStore = MainStore();
  AuthStore authStore;
  ThemeStore themeStore;

  @override
  void initState() {
    authStore = mainStore.authStore;
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
                    "assets/images/bannerAuth${themeStore.themeString}.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Observer(
                    builder: (_) {
                      return new AnimatedCrossFade(
                        crossFadeState: authStore.authPage == AuthPages.signin
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                        firstCurve: Curves.fastOutSlowIn,
                        firstChild: SignInWidget(_scaffoldKey),
                        secondChild: SignUpWidget(
                          _scaffoldKey,
                          alreadySigned:
                              authStore.authPage == AuthPages.signupData,
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
