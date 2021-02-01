// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStore, Store {
  final _$authViewModelAtom = Atom(name: '_MainStore.authViewModel');

  @override
  AuthViewModel get authViewModel {
    _$authViewModelAtom.reportRead();
    return super.authViewModel;
  }

  @override
  set authViewModel(AuthViewModel value) {
    _$authViewModelAtom.reportWrite(value, super.authViewModel, () {
      super.authViewModel = value;
    });
  }

  final _$feedViewModelAtom = Atom(name: '_MainStore.feedViewModel');

  @override
  FeedViewModel get feedViewModel {
    _$feedViewModelAtom.reportRead();
    return super.feedViewModel;
  }

  @override
  set feedViewModel(FeedViewModel value) {
    _$feedViewModelAtom.reportWrite(value, super.feedViewModel, () {
      super.feedViewModel = value;
    });
  }

  final _$pictureViewModelAtom = Atom(name: '_MainStore.pictureViewModel');

  @override
  PictureViewModel get pictureViewModel {
    _$pictureViewModelAtom.reportRead();
    return super.pictureViewModel;
  }

  @override
  set pictureViewModel(PictureViewModel value) {
    _$pictureViewModelAtom.reportWrite(value, super.pictureViewModel, () {
      super.pictureViewModel = value;
    });
  }

  final _$themeStoreAtom = Atom(name: '_MainStore.themeStore');

  @override
  ThemeStore get themeStore {
    _$themeStoreAtom.reportRead();
    return super.themeStore;
  }

  @override
  set themeStore(ThemeStore value) {
    _$themeStoreAtom.reportWrite(value, super.themeStore, () {
      super.themeStore = value;
    });
  }

  @override
  String toString() {
    return '''
authViewModel: ${authViewModel},
feedViewModel: ${feedViewModel},
pictureViewModel: ${pictureViewModel},
themeStore: ${themeStore}
    ''';
  }
}
