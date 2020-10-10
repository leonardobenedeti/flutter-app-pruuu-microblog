import 'dart:async';

import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/user/picture_widget/stores/picture.store.dart';
import 'package:Pruuu/features/user/upload_picture_widget/upload_picture.widget.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/themes/theme.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  MainStore mainStore = MainStore();
  AuthStore authStore;
  PictureStore pictureStore;
  ThemeStore themeStore;

  String textoDisclaimer =
      "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.";

  @override
  void initState() {
    authStore = mainStore.authStore;
    pictureStore = mainStore.pictureStore;
    themeStore = mainStore.themeStore;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _build(context),
              ..._listSettings(),
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
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Bubble(
                            margin: BubbleEdges.only(top: 10),
                            alignment: Alignment.topLeft,
                            nip: BubbleNip.leftTop,
                            color: Theme.of(context).cardColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Disclaimer",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Todo código do app permanecerá aberto e livre para todos.",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                PruuuButton(
                                  fullButton: false,
                                  child: Text("Acessar repo"),
                                  buttonType: ButtonType.primary,
                                  onPressed: () {},
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
              Positioned(
                bottom: 10,
                child: PruuuButton(
                  fullButton: false,
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
                  buttonType: ButtonType.danger,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _listSettings() {
    return <Widget>[
      Divider(height: 1),
      SwitchListTile(
        title: Text(
          "Dark theme",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        activeColor: Theme.of(context).accentColor,
        value: themeStore.isDark,
        onChanged: (value) => themeStore.changeCurrentTheme(),
      ),
      Divider(height: 1),
      SizedBox(height: 16),
    ];
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
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  CloseButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              UploadPictureWidget(
                newUser: false,
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Observer(
                  builder: (_) => new AnimatedCrossFade(
                    crossFadeState: authStore.fillUserInfoState ==
                            FillUserInfoState.openField
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    firstCurve: Curves.fastOutSlowIn,
                    firstChild: _firstChild(),
                    secondChild: _secondChild(),
                  ),
                ),
              ),
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
        height: 50,
        width: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${authStore.userInfo.displayName}",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "${authStore.userInfo.userName}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController _nameController = TextEditingController();

  _secondChild() {
    return Container(
      width: 400,
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              cursorColor: Theme.of(context).accentColor,
              showCursor: true,
              onChanged: _handleChangeText,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                suffixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                      icon: Icon(Icons.close),
                      color: Theme.of(context).accentColor,
                      onPressed: authStore.closeTextField),
                ),
                hintText: "${authStore.userInfo.displayName}",
              ),
            ),
          ),
          Observer(builder: (_) {
            return PruuuButton(
              child: Text("Salvar"),
              fullButton: false,
              loading: authStore.fillUserInfoState == FillUserInfoState.loading,
              onPressed: _allCorrect
                  ? () => authStore.fillUserInfo(
                        displayName: _nameController.text,
                        newUser: false,
                      )
                  : null,
            );
          }),
        ],
      ),
    );
  }

  bool _allCorrect = false;
  _handleChangeText(String value) {
    setState(() {
      _allCorrect = value.length >= 3;
    });
  }
}
