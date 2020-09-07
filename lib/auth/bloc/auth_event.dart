part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class StartApp extends AuthEvent {}

class ChangeScreenAuth extends AuthEvent {
  AuthState state;

  ChangeScreenAuth(this.state);
}
