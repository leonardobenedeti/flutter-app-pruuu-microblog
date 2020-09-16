import 'dart:async';

import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  AuthStore authStore = MainStore().authStore;

  String textoDisclaimer =
      "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _build(context),
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
                          "Leonardo Benedeti",
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
              onPressed: () {
                Timer(Duration(milliseconds: 300), () {
                  Navigator.pop(context);
                });
                authStore.doSignOut();
              },
              textColor: Colors.redAccent[700],
            )
          ],
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Container(
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
                child: _pictureUser(),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                  child: Observer(
                builder: (_) => new AnimatedCrossFade(
                  crossFadeState:
                      authStore.fillUserInfoState == FillUserInfoState.filled
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 500),
                  firstCurve: Curves.fastOutSlowIn,
                  firstChild: _firstChild(),
                  secondChild: _secondChild(),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  _firstChild() {
    return GestureDetector(
      onTap: authStore.openTextField,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Text(
          "${authStore.user.displayName}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  TextEditingController _nameController = TextEditingController();

  _secondChild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          cursorColor: Colors.black,
          showCursor: true,
          onChanged: _handleChangeText,
          controller: _nameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: SizedBox(
                height: 20,
                width: 20,
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: authStore.closeTextField),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: .5),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: .8),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "Como podemos te chamar ?"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Observer(builder: (_) {
              return PruuuButton(
                child: Text("Salvar"),
                loading:
                    authStore.fillUserInfoState == FillUserInfoState.loading,
                onPressed: _allCorrect
                    ? () => authStore.fillUserInfo(_nameController.text)
                    : null,
              );
            }),
          ],
        )
      ],
    );
  }

  bool _allCorrect = false;
  _handleChangeText(String value) {
    setState(() {
      _allCorrect = value.length >= 3;
    });
  }

  Widget _pictureUser() {
    return Observer(
      builder: (context) {
        return authStore.user != null && authStore.user.photoUrl != null
            ? ClipOval(
                child: Image.network(authStore.user.photoUrl),
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
              );
      },
    );
  }
}
