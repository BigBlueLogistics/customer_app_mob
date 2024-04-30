import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/usecases/auth/sign_in.dart';
import 'package:customer_app_mob/core/shared/enums/auth_status.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/shared_prefs.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;

  AuthBloc(this._signInUseCase)
      : super(const AuthState(status: LoadingStatus.idle)) {
    on<AuthSignIn>(_authSigIn);
    on<ResetPassword>(_resetPassword);
  }

  FutureOr<void> _authSigIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: LoadingStatus.loading));

    debugPrint('signin loading 1');
    final authData = await _signInUseCase(
        SignInParams(email: event.email, password: event.password));

    if (authData is DataSuccess && authData.resp != null) {
      if (kDebugMode) {
        print('AuthSuccessStatez');
        print(authData.resp);
      }

      // Cache API token
      final String token = authData.resp!.data!.containsKey('token')
          ? authData.resp!.data!['token']
          : '';
      SharedPrefs.setApiToken(token);

      emit(
        AuthState(
          status: LoadingStatus.success,
          auth: AuthStatus.authenticated,
          user: UserModel(
              data: authData.resp!.data,
              message: authData.resp!.message,
              status: authData.resp!.status),
        ),
      );
    }

    if (authData is DataFailed) {
      if (kDebugMode) {
        print('AuthFailedState error');
        print(authData.error!.response);
      }
      emit(
        AuthStateFailed(
            status: LoadingStatus.failed,
            error: authData.error as DioException),
      );
    }
  }

  FutureOr<void> _resetPassword(ResetPassword event, emit) async {
    emit(const AuthState(status: LoadingStatus.loading));
    debugPrint('Reset password AuthLoadingState');

    await Future.delayed(const Duration(seconds: 3), () {
      debugPrint('Reset password AuthSuccessState');
      emit(
        const AuthState(
          status: LoadingStatus.success,
          auth: AuthStatus.unknown,
          user: UserModel.empty,
        ),
      );
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
