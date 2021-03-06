import 'package:Pruuu/main_store.dart';
import 'package:Pruuu/themes/theme_store.dart';
import 'package:Pruuu/view/auth/auth_page.dart';
import 'package:Pruuu/view_model/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'view/home/home_page.dart';

AuthViewModel authViewModel = MainStore().authViewModel;
ThemeStore themeStore = MainStore().themeStore;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authViewModel.getUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    themeStore.changeStatusBar();
    return Observer(
      builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeStore.currentThemeData,
          home: authViewModel.authState == AuthState.signed
              ? MyHomePage()
              : AuthPage()),
    );
  }
}
