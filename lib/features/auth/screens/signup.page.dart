import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class SignUpWidget extends StatefulWidget {
  bool alreadySigned;

  SignUpWidget({
    this.alreadySigned = false,
  });

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
  TextEditingController _usernameController = new TextEditingController();

  AuthStore authStore = MainStore().authStore;

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
                  onPressed: authStore.changePage,
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
            Observer(
              builder: (_) => PruuuButton(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Criar conta",
                    ),
                  ),
                ),
                loading:
                    authStore.fillUserInfoState == FillUserInfoState.loading,
                onPressed: _handlePressedButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Function _handlePressedButton() {
    if (_allCorrect1 &&
        !_allCorrect2 &&
        authStore.authPage != AuthPages.signupData) {
      return () =>
          authStore.doSignUp(_emailController.text, _passwordController.text);
    }
    if (_allCorrect1 && _allCorrect2) {
      return () => authStore.fillUserInfo(username: _usernameController.text);
    }

    return null;
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
                hintText: "Como podemos te chamar ?"),
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

      if (authStore.authPage == AuthPages.signupData) {
        _allCorrect2 = _usernameController.text.length > 3;
      }
    });
  }
}
