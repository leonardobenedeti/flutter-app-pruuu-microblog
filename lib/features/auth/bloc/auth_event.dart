part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class StartApp extends AuthEvent {}

class ChangeScreenAuth extends AuthEvent {
  AuthState state;

  ChangeScreenAuth(this.state);
}

class SignUpApp extends AuthEvent {
  String email;
  String password;

  SignUpApp({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];

  @override
  String toString() => 'SignUpApp { email: $email, password: $password }';
}

class UpdateUser extends AuthEvent {
  String name;
  String username;
  String picturePath;

  UpdateUser({
    this.name,
    this.username,
    this.picturePath,
  });

  @override
  List<Object> get props => [name, username, picturePath];

  @override
  String toString() =>
      'UpdateUser { name: $name, username: $username, picturePath: $picturePath }';
}

class SignInApp extends AuthEvent {
  String email;
  String password;

  SignInApp({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];

  @override
  String toString() => 'SignInApp { email: $email, password: $password }';
}

class SignOutApp extends AuthEvent {
  BuildContext context;
  SignOutApp(this.context);
}
