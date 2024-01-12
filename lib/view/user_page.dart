import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/themes/theme_store.dart';
import 'package:pruuu/utils/assets.dart';
import 'package:pruuu/utils/strings.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';
import 'package:pruuu/view_model/picture/picture_view_model.dart';
import 'package:pruuu/widgets/button.dart';
import 'package:pruuu/widgets/picture/upload_picture_widget.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MainStore mainStore = MainStore();
  late AuthViewModel authViewModel;
  late PictureViewModel pictureViewModel;
  late ThemeStore themeStore;

  @override
  void initState() {
    authViewModel = mainStore.authViewModel;
    pictureViewModel = mainStore.pictureViewModel;
    themeStore = mainStore.themeStore;
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
                    Strings.exitApp,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Timer(Duration(milliseconds: 300), () {
                      Navigator.pop(context);
                    });
                    authViewModel.doSignOut(_scaffoldKey);
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
          Strings.darkTheme,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        activeColor: Theme.of(context).canvasColor,
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
                      Strings.connectedUser,
                      style: Theme.of(context).textTheme.displayLarge,
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
                    crossFadeState: authViewModel.fillUserInfoState ==
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
      onTap: authViewModel.openTextField,
      child: Container(
        height: 50,
        width: maxSize,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${authViewModel.userInfo.displayName}",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "${authViewModel.userInfo.userName}",
              style: Theme.of(context).textTheme.bodyLarge,
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
              cursorColor: Theme.of(context).canvasColor,
              showCursor: true,
              onChanged: _handleChangeText,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                suffixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                      icon: Icon(Icons.close),
                      color: Theme.of(context).canvasColor,
                      onPressed: authViewModel.closeTextField),
                ),
                hintText: "${authViewModel.userInfo.displayName}",
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
                  child: Text(Strings.save),
                  loading: authViewModel.fillUserInfoState ==
                      FillUserInfoState.loading,
                  onPressed: _allCorrect
                      ? () => authViewModel.fillUserInfo(
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
    return Container(
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
              child: Image.asset(Assets.myProfile),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.me,
                  style: Theme.of(context).textTheme.displaySmall,
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
                        Strings.disclaimer,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        Strings.myDisclaimer,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyLarge,
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
    );
  }
}
