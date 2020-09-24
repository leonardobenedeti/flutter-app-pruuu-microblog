import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _allCorrect = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthStore authStore = MainStore().authStore;

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
                  style: Theme.of(context).textTheme.headline1,
                ),
                PruuuButton(
                  child: Text("Criar conta"),
                  onPressed: authStore.changePage,
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
                decoration: InputDecoration(hintText: "Email"),
                style: Theme.of(context).textTheme.bodyText1,
                buildCounter: (context,
                        {currentLength, isFocused, maxLength}) =>
                    Text("")),
            TextField(
              cursorColor: Theme.of(context).accentColor,
              showCursor: true,
              obscureText: true,
              controller: _passwordController,
              onChanged: _handleChangeText,
              decoration: InputDecoration(hintText: "Senha"),
              style: Theme.of(context).textTheme.bodyText1,
              buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                  Text("ex.: Senha@123"),
            ),
            SizedBox(
              height: 16,
            ),
            Observer(
              builder: (_) => Container(
                width: double.infinity,
                child: Center(
                  child: PruuuButton(
                    child: Text("Entrar"),
                    onPressed: _allCorrect
                        ? () => authStore.doSignIn(
                              _emailController.text,
                              _passwordController.text,
                            )
                        : null,
                    loading: authStore.authState == AuthState.signing,
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
      _allCorrect = _emailController.text.contains("@") &&
          _passwordController.text.length > 5;
    });
  }
}
