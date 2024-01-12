import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/utils/string_validator.dart';
import 'package:pruuu/utils/strings.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';
import 'package:pruuu/widgets/button.dart';
import 'package:pruuu/widgets/picture/upload_picture_widget.dart';

class SignUpWidget extends StatefulWidget {
  final bool alreadySigned;

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

  AuthViewModel authViewModel = MainStore().authViewModel;

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
                  Strings.signUp,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                PruuuButton(
                  child: Text(Strings.alreadyHaveAnAccount),
                  onPressed: authViewModel.changePage,
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
                progressColor: Theme.of(context).canvasColor,
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
                      widget.alreadySigned ? Strings.signUp : Strings.nextStep,
                    ),
                  ),
                ),
                loading: authViewModel.fillUserInfoState ==
                        FillUserInfoState.loading ||
                    authViewModel.authState == AuthState.signing,
                onPressed: _handlePressedButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback? _handlePressedButton() {
    if (_allCorrect1 &&
        !_allCorrect2 &&
        authViewModel.authPage != AuthPages.signupData) {
      return () => authViewModel.doSignUp(
          _emailController.text, _passwordController.text, widget._scaffoldKey);
    }
    if (_allCorrect1 && _allCorrect2) {
      return () => authViewModel.fillUserInfo(
            username: _usernameController.text,
            displayName: _displayNameController.text,
            pictureUrl: authViewModel.user!.photoURL!,
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
          cursorColor: Theme.of(context).canvasColor,
          showCursor: true,
          controller: _displayNameController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          onChanged: _handleChangeText,
          decoration: InputDecoration(hintText: "Como podemos te chamar ?"),
          style: Theme.of(context).textTheme.bodyLarge,
          buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) =>
              Text(
            "ex.: Tiozinho da praça",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        TextFormField(
          cursorColor: Theme.of(context).cardColor,
          showCursor: true,
          controller: _usernameController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          onChanged: _handleChangeText,
          decoration: InputDecoration(hintText: "@usuario"),
          style: Theme.of(context).textTheme.bodyLarge,
          buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) =>
              Text(
            "ex.: @tiozinho",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _contentFirstStep() {
    return Column(
      children: [
        TextFormField(
          cursorColor: Theme.of(context).cardColor,
          showCursor: true,
          controller: _emailController,
          onChanged: _handleChangeText,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: "Email"),
          style: Theme.of(context).textTheme.bodyLarge,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            bool valid = _emailController.text.isValidEmail() ||
                _emailController.text.isEmpty;
            String text =
                valid ? "ex.: user@email.com" : "Digite um email válido";
            return Text(
              text,
              style: valid
                  ? Theme.of(context).textTheme.bodyLarge
                  : TextStyle(color: Colors.red),
            );
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          cursorColor: Theme.of(context).canvasColor,
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
          style: Theme.of(context).textTheme.bodyLarge,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            bool valid = _passwordController.text.isValidPassword() ||
                _passwordController.text.isEmpty;
            String text = valid ? "ex.: Senha@123" : "Digite uma senha válida";
            return Text(
              text,
              style: valid
                  ? Theme.of(context).textTheme.bodyLarge
                  : TextStyle(color: Colors.red),
            );
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          cursorColor: Theme.of(context).canvasColor,
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
          style: Theme.of(context).textTheme.bodyLarge,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
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
                  ? Theme.of(context).textTheme.bodyLarge
                  : TextStyle(color: Colors.red),
            );
          },
        ),
      ],
    );
  }

  double percentFilled = 0;
  late File filePicture;

  _handleChangeText(String text) {
    setState(() {
      double perStep = .15;
      percentFilled = .04;
      percentFilled += _emailController.text.contains("@") ? perStep : 0;
      percentFilled += _passwordController.text.length > 5 ? perStep : 0;
      percentFilled += _confirmController.text.length > 5 ? perStep : 0;
      percentFilled += filePicture.isAbsolute ? perStep : 0;
      percentFilled += _usernameController.text.length >= 3 ? perStep : 0;
      percentFilled += _displayNameController.text.length >= 3 ? perStep : 0;

      _allCorrect1 = _emailController.text.contains("@") &&
          _passwordController.text.length > 5 &&
          _confirmController.text.length > 5 &&
          _passwordController.text == _confirmController.text;

      if (authViewModel.authPage == AuthPages.signupData) {
        _allCorrect2 = _usernameController.text.length > 3 &&
            _displayNameController.text.length > 3;
      }
    });
  }
}
