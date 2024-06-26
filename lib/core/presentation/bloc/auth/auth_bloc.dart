import 'dart:async';
import 'package:customer_app_mob/core/usecases/auth/sign_out.dart';
import 'package:customer_app_mob/core/utils/utils.dart';
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
  final SignOutUseCase _signOutUseCase;

  AuthBloc(this._signInUseCase, this._signOutUseCase)
      : super(const AuthState(status: LoadingStatus.idle)) {
    on<AuthSignIn>(_authSigIn);
    on<AuthSignOut>(_authSignOut);
    on<ResetPassword>(_resetPassword);
  }

  FutureOr<void> _authSigIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: LoadingStatus.loading));

    final authData = await _signInUseCase(
        SignInParams(email: event.email, password: event.password));

    if (authData is DataSuccess && authData.resp != null) {
      // Cache API token
      final String token = authData.resp!.data!.containsKey('token')
          ? authData.resp!.data!['token']
          : '';
      await SharedPrefs.setApiToken(token);

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
    } else {
      emit(
        AuthStateFailed(
            status: LoadingStatus.failed,
            error: authData.error as DioException),
      );
    }
  }

  FutureOr<void> _authSignOut(
      AuthSignOut event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: LoadingStatus.loading));

    final authSignOut = await _signOutUseCase(null);

    if (authSignOut is DataSuccess && authSignOut.resp != null) {
      // Remove cache API token
      await SharedPrefs.removeApiToken();

      emit(
        AuthState(
          status: LoadingStatus.success,
          auth: AuthStatus.unauthenticated,
          user: UserModel.empty,
        ),
      );
    } else {
      emit(
        AuthStateFailed(
            status: LoadingStatus.failed,
            error: authSignOut.error as DioException),
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
