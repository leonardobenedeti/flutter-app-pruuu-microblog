import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()..add(StartApp()),
      child: _blocListener(context),
    );
  }

  Widget _blocListener(BuildContext contextoBloc) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSigned) {
          user = state.user;
        }
        if (state is AuthSignedOut) {
          Navigator.pop(context);
          BlocProvider.of<AuthBloc>(contextoBloc)..add(StartApp());
        }
      },
      child: _blocChild(context),
    );
  }

  Widget _blocChild(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSigned) {
          return _build(context);
        } else if (state is AuthSignedOut || state is AuthInitial) {
          return Container();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _build(BuildContext context) {
    String name;
    String username;

    var split = user.displayName != null ? user.displayName.split("@") : [];
    if (split.length > 1) {
      name = split[0] != null ? split[0] : "";
      username = split[1] != null ? split[1] : "";
    } else {
      name = "Vazio";
      username = "preencheai";
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Usuário conectado",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            user != null && user.photoUrl != null
                ? ClipOval(
                    child: Image.network(user.photoUrl),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      color: Colors.black,
                    ),
                  ),
            SizedBox(
              width: 16,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      user != null && user.displayName != null
                          ? name
                          : "glygjygj",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("@$username"),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            FlatButton(
              child: Text(
                "Sair do app",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () =>
                  BlocProvider.of<AuthBloc>(context).add(SignOutApp(context)),
              textColor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
