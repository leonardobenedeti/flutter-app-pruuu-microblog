import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWidget extends StatefulWidget {
  BuildContext blocContext;
  bool loadingSignIn;

  SignInWidget(this.blocContext, {this.loadingSignIn = false});

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _allCorrect = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _signup,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
                cursorColor: Colors.black,
                showCursor: true,
                controller: _emailController,
                onChanged: _handleChangeText,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: .5),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: .8),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Email"),
                buildCounter: (context,
                        {currentLength, isFocused, maxLength}) =>
                    Text("")),
            TextField(
              cursorColor: Colors.black,
              showCursor: true,
              obscureText: true,
              controller: _passwordController,
              onChanged: _handleChangeText,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: .5),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: .8),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Senha"),
              buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                  Text("ex.: Senha@123"),
            ),
            SizedBox(
              height: 16,
            ),
            FlatButton(
              child: Container(
                width: double.infinity,
                child: Center(
                    child: widget.loadingSignIn
                        ? CircularProgressIndicator()
                        : Text("Entrar")),
              ),
              onPressed: _allCorrect ? () => _doSignIn() : null,
              textColor: Colors.white,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }

  _handleChangeText(String text) {
    setState(() {
      _allCorrect = _emailController.text.contains("@") &&
          _passwordController.text.length > 3;
    });
  }

  _doSignIn() {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(SignInApp(
          email: _emailController.text, password: _passwordController.text));
  }

  _signup() {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(ChangeScreenAuth(AuthSignUp()));
  }
}
