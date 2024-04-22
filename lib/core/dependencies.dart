import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:customer_app_mob/config/constants/url.dart';
import 'package:customer_app_mob/core/data/data_sources/api/auth/auth_api.dart';
import 'package:customer_app_mob/core/data/repository/auth_repository.dart';
import 'package:customer_app_mob/core/domain/usecases/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio()
    ..options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 5),
      baseUrl: AppConstant.apiUrlDevAndroid,
      headers: {
        'Accept': 'application/json',
      },
    )
    // Dio log http request
    ..interceptors.add(
      PrettyDioLogger(
        request: true,
        error: true,
        compact: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );

  // Dio
  getIt.registerSingleton<Dio>(dio);

  // Dependencies
  getIt.registerSingleton<AuthApi>(
    AuthApi(getIt()),
  );

  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerSingleton<SignInUseCase>(
    SignInUseCase(getIt()),
  );

  // Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt()),
  );
}
