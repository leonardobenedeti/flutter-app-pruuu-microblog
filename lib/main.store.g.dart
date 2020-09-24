// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStore, Store {
  final _$authStoreAtom = Atom(name: '_MainStore.authStore');

  @override
  AuthStore get authStore {
    _$authStoreAtom.reportRead();
    return super.authStore;
  }

  @override
  set authStore(AuthStore value) {
    _$authStoreAtom.reportWrite(value, super.authStore, () {
      super.authStore = value;
    });
  }

  final _$feedStoreAtom = Atom(name: '_MainStore.feedStore');

  @override
  FeedStore get feedStore {
    _$feedStoreAtom.reportRead();
    return super.feedStore;
  }

  @override
  set feedStore(FeedStore value) {
    _$feedStoreAtom.reportWrite(value, super.feedStore, () {
      super.feedStore = value;
    });
  }

  final _$pictureStoreAtom = Atom(name: '_MainStore.pictureStore');

  @override
  PictureStore get pictureStore {
    _$pictureStoreAtom.reportRead();
    return super.pictureStore;
  }

  @override
  set pictureStore(PictureStore value) {
    _$pictureStoreAtom.reportWrite(value, super.pictureStore, () {
      super.pictureStore = value;
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
authStore: ${authStore},
feedStore: ${feedStore},
pictureStore: ${pictureStore},
themeStore: ${themeStore}
    ''';
  }
}
