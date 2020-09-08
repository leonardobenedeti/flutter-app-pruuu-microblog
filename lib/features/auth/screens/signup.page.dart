import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatefulWidget {
  BuildContext blocContext;
  bool alreadySigned;

  SignUpWidget(this.blocContext, {this.alreadySigned = false});

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _allCorrect1 = false;
  bool _allCorrect2 = false;
  bool _loading = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();

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
                  onPressed: _signin,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            widget.alreadySigned ? _contentSecondStep() : _contentFirstStep(),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 3,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 3,
                    color: widget.alreadySigned ? Colors.black : Colors.black54,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 3,
                    color: _loading ? Colors.black : Colors.black54,
                  ),
                ),
              ],
            ),
            FlatButton(
              child: Container(
                width: double.infinity,
                child: Center(child: Text("Criar conta")),
              ),
              onPressed: _allCorrect1
                  ? () => (widget.alreadySigned && _allCorrect2)
                      ? _updateInfos(
                          _nameController.text, _usernameController.text, "")
                      : _doSignUp(
                          _emailController.text, _passwordController.text)
                  : null,
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

  Widget _contentSecondStep() {
    return Column(
      children: [
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
            cursorColor: Colors.black,
            showCursor: true,
            onChanged: _handleChangeText,
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: .5),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: .8),
                    borderRadius: BorderRadius.circular(10)),
                hintText: "Como podemos te chamar ?"),
            buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                Text("")),
        TextFormField(
            cursorColor: Colors.black,
            showCursor: true,
            controller: _usernameController,
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
            buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                Text("")),
      ],
    );
  }

  Widget _contentFirstStep() {
    return Column(
      children: [
        TextField(
            cursorColor: Colors.black,
            showCursor: true,
            controller: _emailController,
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
            buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                Text("")),
        TextField(
          cursorColor: Colors.black,
          showCursor: true,
          obscureText: true,
          controller: _passwordController,
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
          cursorColor: Colors.black,
          showCursor: true,
          obscureText: true,
          controller: _confirmController,
          onChanged: _handleChangeText,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: .5),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: .8),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "Confirmação de Senha"),
          buildCounter: (context, {currentLength, isFocused, maxLength}) =>
              Text("ex.: Senha@123"),
        ),
      ],
    );
  }

  _handleChangeText(String text) {
    setState(() {
      _allCorrect1 = _emailController.text.contains("@") &&
          _passwordController.text.length > 3 &&
          _confirmController.text.length > 3 &&
          _passwordController.text == _confirmController.text;

      _allCorrect2 = _nameController.text.length > 3 &&
          _usernameController.text.length > 3;

      _allCorrect1 = (widget.alreadySigned && _allCorrect2);
    });
  }

  _doSignUp(String email, String password) {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(SignUpApp(email: email, password: password));
  }

  _updateInfos(String name, String username, String picturePath) {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(
          UpdateUser(name: name, username: username, picturePath: picturePath));
  }

  _signin() {
    BlocProvider.of<AuthBloc>(widget.blocContext)
      ..add(ChangeScreenAuth(AuthSignIn()));
  }
}
