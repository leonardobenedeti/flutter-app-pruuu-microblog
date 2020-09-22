import 'package:Pruuu/features/auth/repository/auth.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'auth.store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  AuthPages authPage = AuthPages.signin;

  @action
  void changePage() {
    authPage =
        authPage == AuthPages.signin ? AuthPages.signup : AuthPages.signin;
  }

  @action
  void nextStepSignup() {
    authPage = AuthPages.signupData;
  }

  @observable
  AuthState authState = AuthState.signedOut;

  @observable
  FirebaseUser user;

  @action
  Future<void> getUser() async {
    try {
      FirebaseUser firebaseUser = await AuthRepository().getUser();
      _handleUserResult(firebaseUser: firebaseUser);
    } catch (e) {
      print(e);
      authState = AuthState.signedOut;
    }
  }

  @observable
  FillUserInfoState fillUserInfoState = FillUserInfoState.filled;

  @action
  void openTextField() => fillUserInfoState = FillUserInfoState.openField;

  @action
  void closeTextField() => fillUserInfoState = FillUserInfoState.filled;

  @action
  Future fillUserInfo(
      {String username, String pictureUrl, bool newUser = false}) async {
    try {
      fillUserInfoState = username != null
          ? FillUserInfoState.loading
          : FillUserInfoState.loadingPicture;
      bool userUpdated = await AuthRepository()
          .fillUserInfo(displayName: username, pictureUrl: pictureUrl);
      await getUser();
      fillUserInfoState =
          userUpdated ? FillUserInfoState.filled : FillUserInfoState.fillError;
    } catch (e) {
      print(e);
      fillUserInfoState = FillUserInfoState.fillError;
    }
  }

  @action
  Future doSignIn(String email, String password) async {
    try {
      authState = AuthState.signing;
      AuthResult authResult = await AuthRepository().signIn(email, password);
      _handleUserResult(firebaseUser: authResult.user);
    } catch (e) {
      authState = AuthState.signError;
    }
  }

  @action
  Future doSignUp(String email, String password) async {
    try {
      authState = AuthState.signing;
      AuthResult authResult = await AuthRepository().signUp(email, password);
      _handleUserResult(firebaseUser: authResult.user, newUser: true);
    } catch (e) {
      print(e);
      authState = AuthState.signError;
    }
  }

  @action
  Future doSignOut() async {
    try {
      await AuthRepository().signOut();
      _handleUserResult();
    } catch (e) {
      authState = AuthState.signError;
    }
  }

  _handleUserResult({FirebaseUser firebaseUser, bool newUser = false}) {
    if (firebaseUser != null) {
      user = firebaseUser;
      if (newUser) {
        authPage = AuthPages.signupData;
      } else {
        authState = AuthState.signed;
      }
    } else {
      authState = AuthState.signedOut;
    }
  }
}

enum AuthPages { signin, signup, signupData }
enum AuthState { newUser, signed, signedOut, signError, signing }
enum FillUserInfoState { openField, filled, fillError, loading, loadingPicture }
