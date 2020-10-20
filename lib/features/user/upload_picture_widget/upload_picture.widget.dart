import 'dart:async';

import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/user/picture_widget/stores/picture.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class UploadPictureWidget extends StatefulWidget {
  bool newUser;

  UploadPictureWidget({this.newUser = false});

  @override
  _UploadPictureWidgetState createState() => _UploadPictureWidgetState();
}

class _UploadPictureWidgetState extends State<UploadPictureWidget> {
  MainStore mainStore = MainStore();
  PictureStore pictureStore;
  AuthStore authStore;

  @override
  void initState() {
    pictureStore = mainStore.pictureStore;
    authStore = mainStore.authStore;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizePicture = 120;
    return GestureDetector(
      onTap: _selectSourcePictureBottomSheet,
      child: Observer(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).accentColor,
                width: pictureStore.pictureState == PictureState.uploading
                    ? .5
                    : 1.5,
              ),
            ),
            height: sizePicture,
            width: sizePicture,
            child: Stack(
              children: [
                pictureStore.pictureState == PictureState.uploading
                    ? SizedBox(
                        height: sizePicture + 20,
                        width: sizePicture + 20,
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                Container(
                  height: sizePicture,
                  width: sizePicture,
                  child: authStore.userInfo.profilePicture != null
                      ? ClipOval(
                          child: Image.network(
                            authStore.userInfo.profilePicture,
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
                ),
              ],
            ),
          );
        },
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
                            pictureStore.uploadImage(
                              authStore.user.uid,
                              newUser: widget.newUser,
                            );
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
