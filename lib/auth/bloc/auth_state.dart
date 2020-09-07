part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignIn extends AuthState {}

class AuthSignUp extends AuthState {}

class AuthSigned extends AuthState {}

class AuthSignedOut extends AuthState {}
