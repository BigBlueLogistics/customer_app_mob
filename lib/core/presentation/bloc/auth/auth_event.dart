part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignOut extends AuthEvent {
  const AuthSignOut();
}
