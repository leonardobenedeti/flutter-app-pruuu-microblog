import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';

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
}

enum PictureState { initial, loading, ready, error }
