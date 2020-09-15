import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'features/auth/screens/auth.page.dart';
import 'features/home/home.page.dart';

AuthStore authStore = MainStore().authStore;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authStore.getUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        buttonColor: Colors.black87,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black87,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Observer(
        builder: (context) =>
            authStore.authState == AuthState.signed ? MyHomePage() : AuthPage(),
      ),
    );
  }
}
