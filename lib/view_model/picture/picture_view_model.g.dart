// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PictureViewModel on _PictureViewModel, Store {
  late final _$picturePathAtom =
      Atom(name: '_PictureViewModel.picturePath', context: context);

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

  late final _$pictureStateAtom =
      Atom(name: '_PictureViewModel.pictureState', context: context);

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

  late final _$filePictureAtom =
      Atom(name: '_PictureViewModel.filePicture', context: context);

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

  late final _$fetchPictureAsyncAction =
      AsyncAction('_PictureViewModel.fetchPicture', context: context);

  @override
  Future<PictureState> fetchPicture(String uid) {
    return _$fetchPictureAsyncAction.run(() => super.fetchPicture(uid));
  }

  late final _$pickImageAsyncAction =
      AsyncAction('_PictureViewModel.pickImage', context: context);

  @override
  Future<void> pickImage(ImageSource source, String uid) {
    return _$pickImageAsyncAction.run(() => super.pickImage(source, uid));
  }

  late final _$uploadImageAsyncAction =
      AsyncAction('_PictureViewModel.uploadImage', context: context);

  @override
  Future<void> uploadImage(String uid, {bool newUser = false}) {
    return _$uploadImageAsyncAction
        .run(() => super.uploadImage(uid, newUser: newUser));
  }

  late final _$_PictureViewModelActionController =
      ActionController(name: '_PictureViewModel', context: context);

  @override
  dynamic changeState() {
    final _$actionInfo = _$_PictureViewModelActionController.startAction(
        name: '_PictureViewModel.changeState');
    try {
      return super.changeState();
    } finally {
      _$_PictureViewModelActionController.endAction(_$actionInfo);
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
