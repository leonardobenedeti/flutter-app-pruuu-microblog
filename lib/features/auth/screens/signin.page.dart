import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWidget extends StatefulWidget {
  BuildContext blocContext;

  SignInWidget(this.blocContext);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _allCorrect = true;

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
                  onPressed: _allCorrect ? () => _signup() : null,
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
                child: Center(child: Text("Entrar")),
              ),
              onPressed: _allCorrect ? () => print("text") : null,
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
      // _currentPruuu = text;
    });
  }

  _signup() {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(ChangeScreenAuth(AuthSignUp()));
  }
}
