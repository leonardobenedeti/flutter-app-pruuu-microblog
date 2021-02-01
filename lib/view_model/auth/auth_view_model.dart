import 'dart:async';

import 'package:Pruuu/repository/auth_repository.dart';
import 'package:Pruuu/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:Pruuu/utils/error_handler.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = _AuthViewModel with _$AuthViewModel;

abstract class _AuthViewModel with Store {
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
  Future<void> getUser({bool newUser = false}) async {
    try {
      FirebaseUser firebaseUser = await AuthRepository().getUser();
      await getUserInfo();
      _handleUserResult(firebaseUser: firebaseUser, newUser: newUser);
    } catch (e) {
      print(e);
      authState = AuthState.signedOut;
    }
  }

  @observable
  User userInfo = User();

  @action
  Future<void> getUserInfo() async {
    try {
      userInfo = await AuthRepository().getUserInfo();
    } catch (e) {
      print(e);
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
      {String username,
      String pictureUrl,
      String displayName,
      bool newUser = false}) async {
    try {
      fillUserInfoState = username != null
          ? FillUserInfoState.loading
          : FillUserInfoState.loadingPicture;
      bool userUpdated = await AuthRepository().fillUserInfo(
          displayName: displayName,
          pictureUrl: pictureUrl,
          userName: username,
          newUser: newUser);
      await getUser(newUser: newUser);

      fillUserInfoState =
          userUpdated ? FillUserInfoState.filled : FillUserInfoState.fillError;
    } catch (e) {
      print(e);
      fillUserInfoState = FillUserInfoState.fillError;
    }
  }

  @action
  Future doSignIn(String email, String password, _scaffoldKey) async {
    try {
      authState = AuthState.signing;
      AuthResult authResult = await AuthRepository().signIn(email, password);
      await getUser();
      _handleUserResult(firebaseUser: authResult.user);
    } on PlatformException catch (e) {
      authState = AuthState.signError;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.code.getError().getMessage()),
      ));
    }
  }

  @action
  Future doSignUp(String email, String password, _scaffoldKey) async {
    try {
      authState = AuthState.signing;
      AuthResult authResult = await AuthRepository().signUp(email, password);
      _handleUserResult(firebaseUser: authResult.user, newUser: true);
    } on PlatformException catch (e) {
      authState = AuthState.signError;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.code.getError().getMessage()),
      ));
    }
  }

  @action
  Future doSignOut(_scaffoldKey) async {
    try {
      await AuthRepository().signOut();
      _handleUserResult();
    } on PlatformException catch (e) {
      authState = AuthState.signError;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.code.getError().getMessage()),
      ));
    }
  }

  _handleUserResult({FirebaseUser firebaseUser, bool newUser = false}) {
    if (firebaseUser != null) {
      user = firebaseUser;
      if (newUser) {
        if (userInfo.displayName != null && userInfo.profilePicture != null) {
          authPage = AuthPages.signin;
          authState = AuthState.signed;
        } else {
          authPage = AuthPages.signupData;
          authState = AuthState.signedUp;
        }
      } else {
        authState = AuthState.signed;
      }
    } else {
      Timer(Duration(milliseconds: 800), () => userInfo = User());
      authState = AuthState.signedOut;
      authPage = AuthPages.signin;
    }
  }
}

enum AuthPages { signin, signup, signupData }
enum AuthState { newUser, signed, signedOut, signedUp, signError, signing }
enum FillUserInfoState { openField, filled, fillError, loading, loadingPicture }
