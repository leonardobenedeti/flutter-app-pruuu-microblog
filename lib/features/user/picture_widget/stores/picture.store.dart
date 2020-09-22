import 'dart:io';

import 'package:Pruuu/features/auth/repository/auth.repository.dart';
import 'package:Pruuu/features/auth/repository/picture.repository.dart';
import 'package:Pruuu/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'picture.store.g.dart';

class PictureStore = _PictureStore with _$PictureStore;

abstract class _PictureStore with Store {
  @observable
  String picturePath = "";

  @observable
  PictureState pictureState = PictureState.initial;

  static String bucket = "gs://pruuu-214a1.appspot.com";
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: bucket);

  @action
  Future<PictureState> fetchPicture(String uid) async {
    pictureState = PictureState.loading;
    try {
      String url = "$bucket/users/$uid.png";
      StorageReference storageRef = await _storage.getReferenceFromUrl(url);
      picturePath = await storageRef.getDownloadURL();
      pictureState = PictureState.ready;
    } catch (e) {
      pictureState = PictureState.error;
    }
    return pictureState;
  }

  @observable
  File filePicture;

  final ImagePicker _picker = ImagePicker();

  @action
  Future<void> pickImage(ImageSource source, String uid) async {
    pictureState = PictureState.loading;
    try {
      PickedFile pickedFile = await _picker.getImage(source: source);

      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(dir, '$uid.png');
      filePicture = await File(pickedFile.path).copy(newPath);

      pictureState = PictureState.askforCrop;
    } catch (e) {
      pictureState = PictureState.error;
    }
  }

  @action
  Future<void> uploadImage(String uid) async {
    pictureState = PictureState.uploading;

    StorageReference storage = _storage.ref().child("users/$uid.png");

    try {
      StorageUploadTask putFile = storage.putFile(filePicture);

      await putFile.onComplete;
      if (putFile.isSuccessful) {
        bool userSyncronized = await authStore.fillUserInfo(
            pictureUrl: await storage.getDownloadURL());
        pictureState =
            userSyncronized ? PictureState.uploaded : PictureState.uploading;
      } else if (putFile.isInProgress) {
        pictureState = PictureState.uploading;
      } else {
        pictureState = PictureState.error;
      }
    } catch (e) {
      pictureState = PictureState.error;
    }
  }

  @action
  Future<void> changeState() {
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
