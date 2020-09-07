import 'dart:async';

import 'package:Pruuu/auth/repository/local_storage.dart';
import 'package:Pruuu/feed/feed.page.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final localStorage = LocalStorage();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is StartApp) {
      bool hasUser = await localStorage.hasStorage('user');
      yield hasUser ? AuthSigned() : AuthSignIn();
    }
    if (event is ChangeScreenAuth) {
      yield AuthLoading();
      await Future.delayed(Duration(milliseconds: 400));
      yield event.state;
    }
  }
}
