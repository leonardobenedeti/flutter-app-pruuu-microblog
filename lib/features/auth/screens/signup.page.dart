import 'dart:io';

import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/user/upload_picture_widget/upload_picture.widget.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/utils/validators/string_validator.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/percent_indicator.dart';

// ignore: must_be_immutable
class SignUpWidget extends StatefulWidget {
  bool alreadySigned;

  final _scaffoldKey;

  SignUpWidget(
    this._scaffoldKey, {
    this.alreadySigned = false,
  });

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _allCorrect1 = false;
  bool _allCorrect2 = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _displayNameController = new TextEditingController();

  AuthStore authStore = MainStore().authStore;

  bool obscurePassword = true;

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
                  style: Theme.of(context).textTheme.headline1,
                ),
                PruuuButton(
                  child: Text("Já tenho uma conta"),
                  onPressed: authStore.changePage,
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
            Container(
              child: LinearPercentIndicator(
                lineHeight: 2.0,
                percent: percentFilled,
                backgroundColor: Theme.of(context).cardColor,
                progressColor: Theme.of(context).accentColor,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
              ),
            ),
            Observer(
              builder: (_) => PruuuButton(
                fullButton: true,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.alreadySigned ? "Criar conta" : "Próximo passo",
                    ),
                  ),
                ),
                loading:
                    authStore.fillUserInfoState == FillUserInfoState.loading ||
                        authStore.authState == AuthState.signing,
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
      return () => authStore.doSignUp(
          _emailController.text, _passwordController.text, widget._scaffoldKey);
    }
    if (_allCorrect1 && _allCorrect2) {
      return () => authStore.fillUserInfo(
            username: _usernameController.text,
            displayName: _displayNameController.text,
            pictureUrl: authStore.user.photoUrl,
            newUser: true,
          );
    }

    return null;
  }

  Widget _contentSecondStep() {
    return Column(
      children: [
        UploadPictureWidget(
          newUser: true,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          cursorColor: Theme.of(context).accentColor,
          showCursor: true,
          controller: _displayNameController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          onChanged: _handleChangeText,
          decoration: InputDecoration(hintText: "Como podemos te chamar ?"),
          style: Theme.of(context).textTheme.bodyText1,
          buildCounter: (context, {currentLength, isFocused, maxLength}) =>
              Text(
            "ex.: Tiozinho da praça",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        TextFormField(
          cursorColor: Theme.of(context).accentColor,
          showCursor: true,
          controller: _usernameController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          onChanged: _handleChangeText,
          decoration: InputDecoration(hintText: "@usuario"),
          style: Theme.of(context).textTheme.bodyText1,
          buildCounter: (context, {currentLength, isFocused, maxLength}) =>
              Text(
            "ex.: @tiozinho",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  Widget _contentFirstStep() {
    return Column(
      children: [
        TextFormField(
          cursorColor: Theme.of(context).accentColor,
          showCursor: true,
          controller: _emailController,
          onChanged: _handleChangeText,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: "Email"),
          style: Theme.of(context).textTheme.bodyText1,
          buildCounter: (context, {currentLength, isFocused, maxLength}) {
            bool valid = _emailController.text.isValidEmail() ||
                _emailController.text.isEmpty;
            String text =
                valid ? "ex.: user@email.com" : "Digite um email válido";
            return Text(
              text,
              style: valid
                  ? Theme.of(context).textTheme.bodyText1
                  : TextStyle(color: Colors.red),
            );
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          cursorColor: Theme.of(context).accentColor,
          showCursor: true,
          obscureText: obscurePassword,
          controller: _passwordController,
          onChanged: _handleChangeText,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Senha",
            suffixIconConstraints: BoxConstraints.tight(Size.square(50)),
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 8),
              child: PruuuButton(
                buttonType: ButtonType.icon,
                child: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () =>
                    setState(() => obscurePassword = !obscurePassword),
              ),
            ),
          ),
          style: Theme.of(context).textTheme.bodyText1,
          buildCounter: (context, {currentLength, isFocused, maxLength}) {
            bool valid = _passwordController.text.isValidPassword() ||
                _passwordController.text.isEmpty;
            String text = valid ? "ex.: Senha@123" : "Digite uma senha válida";
            return Text(
              text,
              style: valid
                  ? Theme.of(context).textTheme.bodyText1
                  : TextStyle(color: Colors.red),
            );
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          cursorColor: Theme.of(context).accentColor,
          showCursor: true,
          obscureText: obscurePassword,
          controller: _confirmController,
          onChanged: _handleChangeText,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Confirmação de Senha",
            suffixIconConstraints: BoxConstraints.tight(Size.square(50)),
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 8),
              child: PruuuButton(
                buttonType: ButtonType.icon,
                child: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () =>
                    setState(() => obscurePassword = !obscurePassword),
              ),
            ),
          ),
          style: Theme.of(context).textTheme.bodyText1,
          buildCounter: (context, {currentLength, isFocused, maxLength}) {
            bool valid = (_confirmController.text.isValidPassword() &&
                    _confirmController.text == _passwordController.text) ||
                _confirmController.text.isEmpty;
            String text = valid
                ? "ex.: Senha@123"
                : _confirmController.text != _passwordController.text
                    ? "As senhas devem ser iguais"
                    : "Digite uma senha válida";
            return Text(
              text,
              style: valid
                  ? Theme.of(context).textTheme.bodyText1
                  : TextStyle(color: Colors.red),
            );
          },
        ),
      ],
    );
  }

  double percentFilled = 0;
  File filePicture;

  _handleChangeText(String text) {
    setState(() {
      double perStep = .15;
      percentFilled = .04;
      percentFilled += _emailController.text.contains("@") ? perStep : 0;
      percentFilled += _passwordController.text.length > 5 ? perStep : 0;
      percentFilled += _confirmController.text.length > 5 ? perStep : 0;
      percentFilled += filePicture != null ? perStep : 0;
      percentFilled += _usernameController.text.length >= 3 ? perStep : 0;
      percentFilled += _displayNameController.text.length >= 3 ? perStep : 0;

      _allCorrect1 = _emailController.text.contains("@") &&
          _passwordController.text.length > 5 &&
          _confirmController.text.length > 5 &&
          _passwordController.text == _confirmController.text;

      if (authStore.authPage == AuthPages.signupData) {
        _allCorrect2 = _usernameController.text.length > 3 &&
            _displayNameController.text.length > 3;
      }
    });
  }
}
