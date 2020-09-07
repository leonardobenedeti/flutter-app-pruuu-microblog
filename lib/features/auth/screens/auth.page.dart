import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:Pruuu/features/auth/screens/signin.page.dart';
import 'package:Pruuu/features/auth/screens/signup.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()..add(ChangeScreenAuth(AuthSignIn())),
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
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
                  "assets/images/bannerAuth.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (contextBloc, state) {
                    if (state is AuthSignIn) {
                      return SignInWidget(contextBloc);
                    } else if (state is AuthSignUp) {
                      return SignUpWidget(contextBloc);
                    } else {
                      return Container(
                          height: MediaQuery.of(context).size.height * .7,
                          child: Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.black),
                          )));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
