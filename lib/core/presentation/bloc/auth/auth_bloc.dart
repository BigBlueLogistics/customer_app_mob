import 'dart:async';

import 'package:customer_app_mob/core/utils/shared_prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/domain/entities/user.dart';
import 'package:customer_app_mob/core/domain/usecases/auth.dart';
import 'package:customer_app_mob/core/shared/enums/auth_status.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthState()) {
    on<AuthSignIn>(_authSigIn);
    on<ResetPassword>(_resetPassword);
  }

  FutureOr<void> _authSigIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    debugPrint('signin loading 1');
    final authData = await _authUseCase(
        params: SignInParams(email: event.email, password: event.password));

    if (authData is DataSuccess && authData.resp != null) {
      if (kDebugMode) {
        print('AuthSuccessState');
        print(authData);
      }

      // Cache api token
      final String token = authData.resp!.data!.containsKey('token')
          ? authData.resp!.data!['token']
          : '';
      SharedPrefs.setApiToken(token);

      emit(
        AuthSuccessState(
            auth: AuthStatus.authentiated, user: authData.resp as UserEntity),
      );
    }

    if (authData is DataFailed) {
      if (kDebugMode) {
        print('AuthFailedState error');
        print(authData.error!.response);
      }
      emit(AuthFailedState(error: authData.error as DioException));
    }
  }

  FutureOr<void> _resetPassword(ResetPassword event, emit) async {
    emit(AuthLoadingState());
    debugPrint('Reset password AuthLoadingState');

    await Future.delayed(const Duration(seconds: 3), () {
      debugPrint('Reset password AuthSuccessState');
      emit(
        const AuthSuccessState(
            auth: AuthStatus.authentiated, user: UserModel.empty),
      );
    });
  }
}
