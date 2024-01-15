part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final AuthStatus auth;
  final UserEntity user;

  const AuthSuccessState({required this.auth, required this.user});

  @override
  List<Object> get props => [auth, user];
}

class AuthFailedState extends AuthState {
  final DioException error;

  const AuthFailedState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ResetPasswordState extends AuthState {
  final AuthStatus status;
  final String message;

  const ResetPasswordState({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}
