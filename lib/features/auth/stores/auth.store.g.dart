// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$authPageAtom = Atom(name: '_AuthStore.authPage');

  @override
  AuthPages get authPage {
    _$authPageAtom.reportRead();
    return super.authPage;
  }

  @override
  set authPage(AuthPages value) {
    _$authPageAtom.reportWrite(value, super.authPage, () {
      super.authPage = value;
    });
  }

  final _$authStateAtom = Atom(name: '_AuthStore.authState');

  @override
  AuthState get authState {
    _$authStateAtom.reportRead();
    return super.authState;
  }

  @override
  set authState(AuthState value) {
    _$authStateAtom.reportWrite(value, super.authState, () {
      super.authState = value;
    });
  }

  final _$userAtom = Atom(name: '_AuthStore.user');

  @override
  FirebaseUser get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(FirebaseUser value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction('_AuthStore.getUser');

  @override
  Future<dynamic> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$doSignInAsyncAction = AsyncAction('_AuthStore.doSignIn');

  @override
  Future<dynamic> doSignIn(String email, String password) {
    return _$doSignInAsyncAction.run(() => super.doSignIn(email, password));
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void changePage() {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.changePage');
    try {
      return super.changePage();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextStepSignup() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.nextStepSignup');
    try {
      return super.nextStepSignup();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authPage: ${authPage},
authState: ${authState},
user: ${user}
    ''';
  }
}
