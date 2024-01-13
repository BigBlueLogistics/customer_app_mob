import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:customer_app_mob/core/domain/entities/user.dart';
import 'package:customer_app_mob/core/domain/usecases/auth.dart';
import 'package:customer_app_mob/core/shared/enums/auth_status.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthState()) {
    on<AuthSignIn>(_authSigIn);
  }

  FutureOr<void> _authSigIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final authData = await _authUseCase(
        params: SignInParams(email: event.email, password: event.password));

    if (authData is DataSuccess && authData.resp != null) {
      emit(
        AuthSuccessState(
            auth: AuthStatus.authentiated, user: authData.resp as UserEntity),
      );
    }

    if (authData is DataFailed) {
      if (kDebugMode) {
        print('AuthFailedState error');
        print(authData);
      }
      emit(AuthFailedState(error: authData.error as DioException));
    }
  }
}
