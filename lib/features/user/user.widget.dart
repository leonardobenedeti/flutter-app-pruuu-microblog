import 'dart:async';
import 'dart:io';

import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/user/picture_widget/stores/picture.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  AuthStore authStore = MainStore().authStore;
  PictureStore pictureStore = MainStore().pictureStore;

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
              _pictureUser(),
              SizedBox(
                width: 16,
              ),
              Container(
                  child: Observer(
                builder: (_) => new AnimatedCrossFade(
                  crossFadeState:
                      authStore.fillUserInfoState == FillUserInfoState.openField
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
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
                    ? () =>
                        authStore.fillUserInfo(username: _nameController.text)
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
    double sizePicture = 160;
    return GestureDetector(
      onTap: _selectSourcePictureBottomSheet,
      child: Container(
        height: sizePicture,
        width: sizePicture,
        child: Stack(
          children: [
            Observer(
              builder: (context) {
                if (pictureStore.pictureState == PictureState.uploading) {
                  return SizedBox(
                    height: sizePicture + 10,
                    width: sizePicture + 10,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Observer(
              builder: (context) {
                return Container(
                  height: sizePicture,
                  width: sizePicture,
                  child: authStore.user.photoUrl != null
                      ? ClipOval(
                          child: Image.network(
                            authStore.user.photoUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Container(
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            color: Colors.black,
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _selectSourcePictureBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Observer(
          builder: (_) {
            if (pictureStore.pictureState == PictureState.askforCrop) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.file(pictureStore.filePicture),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PruuuButton(
                          child: Column(
                            children: [
                              Icon(
                                Icons.crop,
                                size: 30,
                              ),
                              Text("Cropp")
                            ],
                          ),
                          onPressed: () => print("do cropp"),
                          buttonType: ButtonType.clear,
                        ),
                        PruuuButton(
                          child: Column(
                            children: [
                              Icon(
                                pictureStore.pictureState ==
                                        PictureState.uploaded
                                    ? Icons.check
                                    : Icons.play_circle_outline,
                                size: 30,
                              ),
                              Text(pictureStore.pictureState ==
                                      PictureState.uploaded
                                  ? "Concluído"
                                  : "Continuar sem crop")
                            ],
                          ),
                          onPressed: () {
                            pictureStore.uploadImage(authStore.user.uid);
                            Timer(Duration(milliseconds: 300),
                                () => Navigator.pop(context));
                          },
                          buttonType: ButtonType.clear,
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PruuuButton(
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                size: 30,
                              ),
                              Text("Câmera")
                            ],
                          ),
                          onPressed: () => pictureStore.pickImage(
                              ImageSource.camera, authStore.user.uid),
                          buttonType: ButtonType.clear,
                        ),
                        PruuuButton(
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_library,
                                size: 30,
                              ),
                              Text("Galeria")
                            ],
                          ),
                          onPressed: () => pictureStore.pickImage(
                              ImageSource.gallery, authStore.user.uid),
                          buttonType: ButtonType.clear,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
