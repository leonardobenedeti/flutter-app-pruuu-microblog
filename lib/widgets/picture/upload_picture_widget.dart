import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/utils/strings.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';
import 'package:pruuu/view_model/picture/picture_view_model.dart';
import 'package:pruuu/widgets/button.dart';

class UploadPictureWidget extends StatefulWidget {
  final bool newUser;

  UploadPictureWidget({this.newUser = false});

  @override
  _UploadPictureWidgetState createState() => _UploadPictureWidgetState();
}

class _UploadPictureWidgetState extends State<UploadPictureWidget> {
  MainStore mainStore = MainStore();
  late PictureViewModel pictureViewModel;
  late AuthViewModel authViewModel;

  @override
  void initState() {
    pictureViewModel = mainStore.pictureViewModel;
    authViewModel = mainStore.authViewModel;
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
                color: Theme.of(context).cardColor,
                width: pictureViewModel.pictureState == PictureState.uploading
                    ? .5
                    : 1.5,
              ),
            ),
            height: sizePicture,
            width: sizePicture,
            child: Stack(
              children: [
                pictureViewModel.pictureState == PictureState.uploading
                    ? SizedBox(
                        height: sizePicture + 20,
                        width: sizePicture + 20,
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                Container(
                  height: sizePicture,
                  width: sizePicture,
                  child: authViewModel.userInfo.profilePicture != null
                      ? ClipOval(
                          child: Image.network(
                            authViewModel.userInfo.profilePicture!,
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
            if (pictureViewModel.pictureState == PictureState.askforCrop) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.file(pictureViewModel.filePicture),
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
                              Text(Strings.crop)
                            ],
                          ),
                          onPressed: () => print("do cropp"),
                          buttonType: ButtonType.clear,
                        ),
                        PruuuButton(
                          child: Column(
                            children: [
                              Icon(
                                pictureViewModel.pictureState ==
                                        PictureState.uploaded
                                    ? Icons.check
                                    : Icons.play_circle_outline,
                                size: 30,
                              ),
                              Text(pictureViewModel.pictureState ==
                                      PictureState.uploaded
                                  ? Strings.done
                                  : Strings.withoutCrop)
                            ],
                          ),
                          onPressed: () {
                            pictureViewModel.uploadImage(
                              authViewModel.user!.uid,
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
                              Text(Strings.camera)
                            ],
                          ),
                          onPressed: () => pictureViewModel.pickImage(
                              ImageSource.camera, authViewModel.user!.uid),
                          buttonType: ButtonType.clear,
                        ),
                        PruuuButton(
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_library,
                                size: 30,
                              ),
                              Text(Strings.gallery)
                            ],
                          ),
                          onPressed: () => pictureViewModel.pickImage(
                              ImageSource.gallery, authViewModel.user!.uid),
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
