import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/screens/auth.page.dart';
import 'features/home/home.page.dart';

void main() {
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()..add(StartApp()),
      child: MyApp(),
    ),
  );
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
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSigned) {}
          },
          child: _blocChild(context),
        ));
  }

  Widget _blocChild(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSigned) {
          return MyHomePage();
        }

        return AuthPage();
      },
    );
  }
}
