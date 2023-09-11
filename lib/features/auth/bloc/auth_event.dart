part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String fName;
  final String lastName;
  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.fName,
    required this.lastName,
  });
}


class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;
  
  AuthSignInEvent({
    required this.email,
    required this.password,

  });
}
