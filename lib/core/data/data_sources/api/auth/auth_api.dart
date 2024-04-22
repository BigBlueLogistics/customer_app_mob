import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/user.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @GET('/auth/login')
  Future<HttpResponse<UserModel>> signIn(
    @Query('email') String email,
    @Query('password') String password,
  );

  @GET('/auth/reset-password')
  Future<HttpResponse<UserModel>> resetPassword(
    @Query('email') String email,
  );
}
