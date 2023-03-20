import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];

  bool get isConfirm => false;
}

class Unauthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  @override
  final bool isConfirm;

  const Authenticated({
    required this.isConfirm,
  });

  @override
  List<Object?> get props => [isConfirm];
}

class LoginFailed extends AuthenticationState {
  final String error;

  const LoginFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
