import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/themes/theme.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'features/auth/screens/auth.page.dart';
import 'features/home/home.page.dart';

AuthStore authStore = MainStore().authStore;
ThemeStore themeStore = MainStore().themeStore;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authStore.getUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeStore.currentThemeData,
          home: authStore.authState == AuthState.signed
              ? MyHomePage()
              : AuthPage()),
    );
  }
}
