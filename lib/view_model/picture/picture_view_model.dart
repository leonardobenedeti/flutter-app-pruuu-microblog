import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';

part 'picture_view_model.g.dart';

class PictureViewModel = _PictureViewModel with _$PictureViewModel;

abstract class _PictureViewModel with Store {
  @observable
  String picturePath = "";

  @observable
  PictureState pictureState = PictureState.initial;

  final FirebaseStorage _storage = FirebaseStorage.instanceFor();

  @action
  Future<PictureState> fetchPicture(String uid) async {
    pictureState = PictureState.loading;
    try {
      String url = "users/$uid.png";
      final storageRef = await _storage.ref(url);
      picturePath = await storageRef.getDownloadURL();
      pictureState = PictureState.ready;
    } catch (e) {
      pictureState = PictureState.error;
    }
    return pictureState;
  }

  @observable
  File filePicture = File('');

  @action
  Future<void> pickImage(ImageSource source, String uid) async {
    pictureState = PictureState.loading;
    try {
      final picker = ImagePicker();
      XFile? image = XFile('');
      final _image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 500,
      );
      image = _image;

      filePicture = File(image!.path);

      pictureState = PictureState.askforCrop;
    } catch (e) {
      pictureState = PictureState.error;
    }
  }

  @action
  Future<void> uploadImage(String uid, {bool newUser = false}) async {
    AuthViewModel authViewModel = MainStore().authViewModel;

    pictureState = PictureState.uploading;

    try {
      final reference = _storage.ref().child("users/$uid.png");
      final taskSnapshot = await reference.putFile(filePicture);

      if (taskSnapshot.state == TaskState.success) {
        bool userSynchronized = await authViewModel.fillUserInfo(
          pictureUrl: await reference.getDownloadURL(),
          newUser: newUser,
        );
        pictureState =
            userSynchronized ? PictureState.uploaded : PictureState.uploading;
      } else {
        pictureState = PictureState.error;
        throw PictureState.error;
      }
    } catch (e) {
      pictureState = PictureState.error;
    }
  }

  @action
  changeState() {
    pictureState = pictureState == PictureState.uploading
        ? PictureState.uploaded
        : PictureState.uploading;
  }
}

enum PictureState {
  initial,
  loading,
  ready,
  error,
  askforCrop,
  uploading,
  uploaded
}
