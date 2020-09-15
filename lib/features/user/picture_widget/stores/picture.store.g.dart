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

  final _$fetchPictureAsyncAction = AsyncAction('_PictureStore.fetchPicture');

  @override
  Future<PictureState> fetchPicture(String uid) {
    return _$fetchPictureAsyncAction.run(() => super.fetchPicture(uid));
  }

  @override
  String toString() {
    return '''
picturePath: ${picturePath},
pictureState: ${pictureState}
    ''';
  }
}
