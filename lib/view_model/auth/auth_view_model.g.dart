// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthViewModel on _AuthViewModel, Store {
  late final _$authPageAtom =
      Atom(name: '_AuthViewModel.authPage', context: context);

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

  late final _$authStateAtom =
      Atom(name: '_AuthViewModel.authState', context: context);

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

  late final _$userAtom = Atom(name: '_AuthViewModel.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$userInfoAtom =
      Atom(name: '_AuthViewModel.userInfo', context: context);

  @override
  UserModel get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(UserModel value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  late final _$fillUserInfoStateAtom =
      Atom(name: '_AuthViewModel.fillUserInfoState', context: context);

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

  late final _$getUserAsyncAction =
      AsyncAction('_AuthViewModel.getUser', context: context);

  @override
  Future<void> getUser({bool newUser = false}) {
    return _$getUserAsyncAction.run(() => super.getUser(newUser: newUser));
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('_AuthViewModel.getUserInfo', context: context);

  @override
  Future<void> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  late final _$fillUserInfoAsyncAction =
      AsyncAction('_AuthViewModel.fillUserInfo', context: context);

  @override
  Future<dynamic> fillUserInfo(
      {String username = '',
      String pictureUrl = '',
      String displayName = '',
      bool newUser = false}) {
    return _$fillUserInfoAsyncAction.run(() => super.fillUserInfo(
        username: username,
        pictureUrl: pictureUrl,
        displayName: displayName,
        newUser: newUser));
  }

  late final _$doSignInAsyncAction =
      AsyncAction('_AuthViewModel.doSignIn', context: context);

  @override
  Future<dynamic> doSignIn(
      String email, String password, dynamic _scaffoldKey) {
    return _$doSignInAsyncAction
        .run(() => super.doSignIn(email, password, _scaffoldKey));
  }

  late final _$doSignUpAsyncAction =
      AsyncAction('_AuthViewModel.doSignUp', context: context);

  @override
  Future<dynamic> doSignUp(
      String email, String password, dynamic _scaffoldKey) {
    return _$doSignUpAsyncAction
        .run(() => super.doSignUp(email, password, _scaffoldKey));
  }

  late final _$doSignOutAsyncAction =
      AsyncAction('_AuthViewModel.doSignOut', context: context);

  @override
  Future<dynamic> doSignOut(dynamic _scaffoldKey) {
    return _$doSignOutAsyncAction.run(() => super.doSignOut(_scaffoldKey));
  }

  late final _$_AuthViewModelActionController =
      ActionController(name: '_AuthViewModel', context: context);

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
