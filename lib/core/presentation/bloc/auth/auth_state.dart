part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.auth = AuthStatus.unauthenticated,
    this.user = UserModel.empty,
  });

  final LoadingStatus status;
  final AuthStatus auth;
  final UserModel user;

  @override
  List<Object> get props => [status];

  Map<String, dynamic> toJson() {
    return {'status': status.index, 'auth': auth.index, 'user': user};
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      status: LoadingStatus.values[json['status']],
      auth: AuthStatus.values[json['auth']],
      user: UserModel.fromJson(
        json['user'],
      ),
    );
  }
}

class AuthStateFailed extends AuthState {
  final DioException error;

  const AuthStateFailed({
    required super.status,
    required this.error,
  });

  @override
  List<Object> get props => [status, error];
}

class ResetPasswordState extends AuthState {
  final String message;

  const ResetPasswordState({required super.status, required this.message});

  @override
  List<Object> get props => [status, message];
}
