import 'package:Pruuu/features/auth/bloc/auth_bloc.dart';
import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  FirebaseUser user;
  String textoDisclaimer =
      "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.";

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
    String username;

    var split = user.displayName != null ? user.displayName.split("@") : [];
    if (split.length > 1) {
      username = split[1] != null ? split[1] : "";
    } else {
      username = "preencheai";
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
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
                    CloseButton(
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Container(
                  height: 160,
                  width: 160,
                  child: user != null && user.photoUrl != null
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
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "@$username",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset("assets/images/perfil-leo.png"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "@leonardobenedeti",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Bubble(
                          margin: BubbleEdges.only(top: 10),
                          alignment: Alignment.topLeft,
                          nip: BubbleNip.leftTop,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Disclaimer",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Todo código do app permanecerá aberto e livre para todos.",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              FlatButton(
                                child: Text("Acessar repo"),
                                color: Colors.black,
                                onPressed: () {},
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Text(
                "Sair do app",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () =>
                  BlocProvider.of<AuthBloc>(context).add(SignOutApp(context)),
              textColor: Colors.redAccent[700],
            )
          ],
        ),
      ),
    );
  }
}
