import 'dart:async';
import 'dart:convert';

import 'package:Pruuu/features/auth/repository/auth.repository.dart';
import 'package:Pruuu/features/auth/repository/local_storage.dart';
import 'package:Pruuu/models/user.modal.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final localStorage = LocalStorage();
  final authRepository = AuthRepository();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is StartApp) {
      yield AuthLoading();
      FirebaseUser user = await authRepository.getUser();
      yield user != null ? AuthSigned(user: user) : AuthSignIn();
    }
    if (event is ChangeScreenAuth) {
      yield AuthLoading();
      await Future.delayed(Duration(milliseconds: 400));
      yield event.state;
    }
    if (event is SignUpApp) {
      yield AuthLoading();
      bool authResult = await authRepository.signUp(
        event.email,
        event.password,
      );
      yield AuthSignUp(signed: authResult);
    }
    if (event is SignInApp) {
      yield (AuthSignIn(signing: true));
      AuthResult authResult =
          await authRepository.signIn(event.email, event.password);
      yield authResult != null
          ? AuthSigned(user: authResult.user)
          : AuthSignIn(signing: false);
    }
    if (event is UpdateUser) {
      yield (AuthSignIn(signing: true));
      authRepository.fillUserInfo(
          event.name, event.username, event.picturePath);
      yield AuthSigned();
    }
    if (event is SignOutApp) {
      yield (AuthSignedOut());
      authRepository.signOut(event.context);
      yield AuthInitial();
    }
    // yield AuthLoading();
  }
}

// atual: 1500 bruto  / 1200 max liquido
// 5k wirginia

// ideal:
