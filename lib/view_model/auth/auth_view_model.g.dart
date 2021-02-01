// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthViewModel on _AuthViewModel, Store {
  final _$authPageAtom = Atom(name: '_AuthViewModel.authPage');

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

  final _$authStateAtom = Atom(name: '_AuthViewModel.authState');

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

  final _$userAtom = Atom(name: '_AuthViewModel.user');

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

  final _$userInfoAtom = Atom(name: '_AuthViewModel.userInfo');

  @override
  User get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(User value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  final _$fillUserInfoStateAtom =
      Atom(name: '_AuthViewModel.fillUserInfoState');

  @override
  FillUserInfoState get fillUserInfoState {
    _$fillUserInfoStateAtom.reportRead();
    return super.fillUserInfoState;
  }

  @override
  set fillUserInfoState(FillUserInfoState value) {
    _$fillUserInfoStateAtom.reportWrite(value, super.fillUserInfoState, () {
      super.fillUserInfoState = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction('_AuthViewModel.getUser');

  @override
  Future<void> getUser({bool newUser = false}) {
    return _$getUserAsyncAction.run(() => super.getUser(newUser: newUser));
  }

  final _$getUserInfoAsyncAction = AsyncAction('_AuthViewModel.getUserInfo');

  @override
  Future<void> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  final _$fillUserInfoAsyncAction = AsyncAction('_AuthViewModel.fillUserInfo');

  @override
  Future<dynamic> fillUserInfo(
      {String username,
      String pictureUrl,
      String displayName,
      bool newUser = false}) {
    return _$fillUserInfoAsyncAction.run(() => super.fillUserInfo(
        username: username,
        pictureUrl: pictureUrl,
        displayName: displayName,
        newUser: newUser));
  }

  final _$doSignInAsyncAction = AsyncAction('_AuthViewModel.doSignIn');

  @override
  Future<dynamic> doSignIn(
      String email, String password, dynamic _scaffoldKey) {
    return _$doSignInAsyncAction
        .run(() => super.doSignIn(email, password, _scaffoldKey));
  }

  final _$doSignUpAsyncAction = AsyncAction('_AuthViewModel.doSignUp');

  @override
  Future<dynamic> doSignUp(
      String email, String password, dynamic _scaffoldKey) {
    return _$doSignUpAsyncAction
        .run(() => super.doSignUp(email, password, _scaffoldKey));
  }

  final _$doSignOutAsyncAction = AsyncAction('_AuthViewModel.doSignOut');

  @override
  Future<dynamic> doSignOut(dynamic _scaffoldKey) {
    return _$doSignOutAsyncAction.run(() => super.doSignOut(_scaffoldKey));
  }

  final _$_AuthViewModelActionController =
      ActionController(name: '_AuthViewModel');

  @override
  void changePage() {
    final _$actionInfo = _$_AuthViewModelActionController.startAction(
        name: '_AuthViewModel.changePage');
    try {
      return super.changePage();
    } finally {
      _$_AuthViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextStepSignup() {
    final _$actionInfo = _$_AuthViewModelActionController.startAction(
        name: '_AuthViewModel.nextStepSignup');
    try {
      return super.nextStepSignup();
    } finally {
      _$_AuthViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openTextField() {
    final _$actionInfo = _$_AuthViewModelActionController.startAction(
        name: '_AuthViewModel.openTextField');
    try {
      return super.openTextField();
    } finally {
      _$_AuthViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void closeTextField() {
    final _$actionInfo = _$_AuthViewModelActionController.startAction(
        name: '_AuthViewModel.closeTextField');
    try {
      return super.closeTextField();
    } finally {
      _$_AuthViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authPage: ${authPage},
authState: ${authState},
user: ${user},
userInfo: ${userInfo},
fillUserInfoState: ${fillUserInfoState}
    ''';
  }
}
