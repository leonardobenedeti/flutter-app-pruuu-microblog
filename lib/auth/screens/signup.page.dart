import 'package:Pruuu/auth/bloc/auth_bloc.dart';
import 'package:Pruuu/auth/screens/signin.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatefulWidget {
  BuildContext blocContext;

  SignUpWidget(this.blocContext);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _allCorrect = true;

  FocusNode _emailNode = new FocusNode();
  FocusNode _senhaNode = new FocusNode();
  FocusNode _nameNode = new FocusNode();
  FocusNode _userNameNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Já tenho uma conta",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _allCorrect ? () => _signin() : null,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
                focusNode: _emailNode,
                cursorColor: Colors.black,
                showCursor: true,
                onChanged: _handleChangeText,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
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
              focusNode: _senhaNode,
              cursorColor: Colors.black,
              showCursor: true,
              obscureText: true,
              onChanged: _handleChangeText,
              textInputAction: TextInputAction.next,
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
            TextField(
                focusNode: _nameNode,
                cursorColor: Colors.black,
                showCursor: true,
                onChanged: _handleChangeText,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: .5),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: .8),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Como podemos te chamar ?"),
                buildCounter: (context,
                        {currentLength, isFocused, maxLength}) =>
                    Text("")),
            TextFormField(
                focusNode: _userNameNode,
                cursorColor: Colors.black,
                showCursor: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                onChanged: _handleChangeText,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: .5),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: .8),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "@username"),
                buildCounter: (context,
                        {currentLength, isFocused, maxLength}) =>
                    Text("")),
            SizedBox(
              height: 16,
            ),
            FlatButton(
              child: Container(
                width: double.infinity,
                child: Center(child: Text("Criar conta")),
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

  _signin() {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(ChangeScreenAuth(AuthSignIn()));
  }
}
