import 'package:Pruuu/main_store.dart';
import 'package:Pruuu/utils/string_validator.dart';
import 'package:Pruuu/utils/strings.dart';
import 'package:Pruuu/view_model/auth/auth_view_model.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignInWidget extends StatefulWidget {
  final _scaffoldKey;

  SignInWidget(this._scaffoldKey);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _allCorrect = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool obscurePassword = true;

  AuthViewModel authViewModel = MainStore().authViewModel;

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
                  Strings.signIn,
                  style: Theme.of(context).textTheme.headline1,
                ),
                PruuuButton(
                  child: Text(Strings.signUp),
                  onPressed: authViewModel.changePage,
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              cursorColor: Theme.of(context).accentColor,
              showCursor: true,
              controller: _emailController,
              onChanged: _handleChangeText,
              decoration: InputDecoration(hintText: Strings.email),
              style: Theme.of(context).textTheme.bodyText1,
              buildCounter: (context, {currentLength, isFocused, maxLength}) {
                bool valid = _emailController.text.isValidEmail() ||
                    _emailController.text.isEmpty;
                String text =
                    valid ? Strings.tipEmail : Strings.placeholderEmail;
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
              decoration: InputDecoration(
                hintText: Strings.password,
                suffixIconConstraints: BoxConstraints.tight(Size.square(50)),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: PruuuButton(
                    buttonType: ButtonType.icon,
                    child: Icon(obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        setState(() => obscurePassword = !obscurePassword),
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.bodyText1,
              buildCounter: (context, {currentLength, isFocused, maxLength}) {
                bool valid = _passwordController.text.isValidPassword() ||
                    _passwordController.text.isEmpty;
                String text =
                    valid ? Strings.tipPassword : Strings.placeholderPassword;
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
            Observer(
              builder: (_) => Container(
                width: double.infinity,
                child: Center(
                  child: PruuuButton(
                    fullButton: true,
                    child: Text(Strings.signIn),
                    onPressed: _allCorrect
                        ? () => authViewModel.doSignIn(_emailController.text,
                            _passwordController.text, widget._scaffoldKey)
                        : null,
                    loading: authViewModel.authState == AuthState.signing,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleChangeText(String text) {
    setState(() {
      _allCorrect = _emailController.text.isValidEmail() &&
          _passwordController.text.isValidPassword();
    });
  }
}
