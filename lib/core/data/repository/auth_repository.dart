import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:customer_app_mob/core/data/data_sources/api/auth/auth_api.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/domain/repository/auth_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;

  const AuthRepositoryImpl(this._authApi);

  @override
  Future<DataState<UserModel>> signIn(
      {required String email, required String password}) async {
    try {
      final resp = await _authApi.signIn(email, password);

      if (resp.response.statusCode == HttpStatus.ok) {
        return DataSuccess(resp.data);
      }

      return DataFailed(
        DioException(
          requestOptions: resp.response.requestOptions,
          response: resp.response,
          message: resp.response.statusMessage,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> resetPassword(String email) async {
    try {
      final resp = await _authApi.resetPassword(email);

      if (resp.response.statusCode == HttpStatus.ok) {
        return DataSuccess(resp.data);
      }

      return DataFailed(
        DioException(
          requestOptions: resp.response.requestOptions,
          response: resp.response,
          message: resp.response.statusMessage,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
