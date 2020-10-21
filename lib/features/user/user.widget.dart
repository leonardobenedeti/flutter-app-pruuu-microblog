import 'dart:async';

import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/picture/stores/picture.store.dart';
import 'package:Pruuu/features/picture/widgets/upload_picture.widget.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/remote_configs/remote_config.store.dart';
import 'package:Pruuu/themes/theme.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:bubble/bubble.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MainStore mainStore = MainStore();
  AuthStore authStore;
  PictureStore pictureStore;
  ThemeStore themeStore;
  RemoteConfigStore remoteConfigStore;

  String textoDisclaimer =
      "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.";

  @override
  void initState() {
    authStore = mainStore.authStore;
    pictureStore = mainStore.pictureStore;
    themeStore = mainStore.themeStore;
    remoteConfigStore = mainStore.remoteConfigStore;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _build(context),
                ..._listSettings(),
                _messageInfo(),
                SizedBox(
                  height: 32,
                ),
                PruuuButton(
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
                    authStore.doSignOut(_scaffoldKey);
                  },
                  buttonType: ButtonType.danger,
                )
              ],
            ),
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
    final sizeChild = MediaQuery.of(context).size.width * .85;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Usuário conectado",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  PruuuButton(
                    buttonType: ButtonType.icon,
                    child: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              UploadPictureWidget(
                newUser: false,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Observer(
                  builder: (_) => new AnimatedCrossFade(
                    crossFadeState: authStore.fillUserInfoState ==
                            FillUserInfoState.openField
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    firstCurve: Curves.fastOutSlowIn,
                    firstChild: _firstChild(sizeChild),
                    secondChild: _secondChild(sizeChild),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _firstChild(double maxSize) {
    return GestureDetector(
      onTap: authStore.openTextField,
      child: Container(
        height: 50,
        width: maxSize,
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

  _secondChild(double maxSize) {
    return Container(
      width: maxSize,
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: maxSize * .65,
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
          SizedBox(
            width: maxSize * .05,
          ),
          Observer(builder: (_) {
            return Center(
              child: SizedBox(
                width: maxSize * .25,
                child: PruuuButton(
                  child: Text("Salvar"),
                  loading:
                      authStore.fillUserInfoState == FillUserInfoState.loading,
                  onPressed: _allCorrect
                      ? () => authStore.fillUserInfo(
                            displayName: _nameController.text,
                            newUser: false,
                          )
                      : null,
                ),
              ),
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

  Widget _messageInfo() {
    return FutureBuilder<RemoteConfig>(
      future: remoteConfigStore.switchDisclaimer(),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        return snapshot.hasData
            ? Visibility(
                visible: snapshot.data.getBool('disclaimer_switch'),
                child: Container(
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
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "App criado como um desafio para uma oportunidade de trabalho onde precisava criar um app com algumas funcionalidades parecidas com a do Twitter.",
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Todo código do app permanecerá aberto e livre para todos.",
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
