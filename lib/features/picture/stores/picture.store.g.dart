// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PictureStore on _PictureStore, Store {
  final _$picturePathAtom = Atom(name: '_PictureStore.picturePath');

  @override
  String get picturePath {
    _$picturePathAtom.reportRead();
    return super.picturePath;
  }

  @override
  set picturePath(String value) {
    _$picturePathAtom.reportWrite(value, super.picturePath, () {
      super.picturePath = value;
    });
  }

  final _$pictureStateAtom = Atom(name: '_PictureStore.pictureState');

  @override
  PictureState get pictureState {
    _$pictureStateAtom.reportRead();
    return super.pictureState;
  }

  @override
  set pictureState(PictureState value) {
    _$pictureStateAtom.reportWrite(value, super.pictureState, () {
      super.pictureState = value;
    });
  }

  final _$filePictureAtom = Atom(name: '_PictureStore.filePicture');

  @override
  File get filePicture {
    _$filePictureAtom.reportRead();
    return super.filePicture;
  }

  @override
  set filePicture(File value) {
    _$filePictureAtom.reportWrite(value, super.filePicture, () {
      super.filePicture = value;
    });
  }

  final _$fetchPictureAsyncAction = AsyncAction('_PictureStore.fetchPicture');

  @override
  Future<PictureState> fetchPicture(String uid) {
    return _$fetchPictureAsyncAction.run(() => super.fetchPicture(uid));
  }

  final _$pickImageAsyncAction = AsyncAction('_PictureStore.pickImage');

  @override
  Future<void> pickImage(ImageSource source, String uid) {
    return _$pickImageAsyncAction.run(() => super.pickImage(source, uid));
  }

  final _$uploadImageAsyncAction = AsyncAction('_PictureStore.uploadImage');

  @override
  Future<void> uploadImage(String uid, {bool newUser = false}) {
    return _$uploadImageAsyncAction
        .run(() => super.uploadImage(uid, newUser: newUser));
  }

  final _$_PictureStoreActionController =
      ActionController(name: '_PictureStore');

  @override
  dynamic changeState() {
    final _$actionInfo = _$_PictureStoreActionController.startAction(
        name: '_PictureStore.changeState');
    try {
      return super.changeState();
    } finally {
      _$_PictureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
picturePath: ${picturePath},
pictureState: ${pictureState},
filePicture: ${filePicture}
    ''';
  }
}
