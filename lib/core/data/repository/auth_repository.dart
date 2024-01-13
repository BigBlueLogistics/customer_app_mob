import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:customer_app_mob/core/data/data_sources/api/auth_api.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/domain/repository/auth_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  const AuthRepositoryImpl(this.authApi);

  @override
  Future<DataState<UserModel>> signIn(String email, String password) async {
    try {
      final resp = await authApi.signIn(email, password);

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
