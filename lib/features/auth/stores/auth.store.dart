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
  Future getUser() async {
    try {
      FirebaseUser firebaseUser = await AuthRepository().getUser();
      _handleUserResult(firebaseUser: firebaseUser);
    } catch (e) {
      print(e);
      authState = AuthState.signedOut;
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
  Future doSignOut() async {
    try {
      await AuthRepository().signOut();
      _handleUserResult();
    } catch (e) {
      authState = AuthState.signError;
    }
  }

  _handleUserResult({FirebaseUser firebaseUser}) {
    if (firebaseUser != null) {
      user = firebaseUser;
      authState = AuthState.signed;
    } else {
      authState = AuthState.signedOut;
    }
  }
}

enum AuthPages { signin, signup, signupData }
enum AuthState { signed, signedOut, signError, signing }
