import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:customer_app_mob/core/utils/shared_prefs.dart';
import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = SharedPrefs.getApiToken();

    // Add header Authorization token
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await HydratedBloc.storage.clear();

      AppRouter.router.go(AppRoutes.signInPathScreen);
    }

    return super.onError(err, handler);
  }
}
