import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String bcrypt;

  const Authenticated({
    required this.bcrypt,
  });

  @override
  List<Object?> get props => [bcrypt];
}

class LoginFailed extends AuthenticationState {
  final String error;

  const LoginFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
