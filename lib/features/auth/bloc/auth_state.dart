part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignIn extends AuthState {
  bool signing;
  AuthSignIn({this.signing = false});
}

class AuthSignUp extends AuthState {
  bool signed;
  AuthSignUp({this.signed = false});
}

class AuthSigned extends AuthState {
  FirebaseUser user;
  AuthSigned({this.user});
}

class AuthSignedOut extends AuthState {}
