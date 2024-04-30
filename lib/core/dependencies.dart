import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:customer_app_mob/core/data/data_sources/api/inventory/inventory_api.dart';
import 'package:customer_app_mob/core/data/repository/inventory_repository.dart';
import 'package:customer_app_mob/core/usecases/inventory/get_inventory.dart';
import 'package:customer_app_mob/core/utils/shared_prefs.dart';
import 'package:customer_app_mob/config/constants/url.dart';
import 'package:customer_app_mob/core/data/data_sources/api/auth/auth_api.dart';
import 'package:customer_app_mob/core/data/repository/auth_repository.dart';
import 'package:customer_app_mob/core/usecases/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';

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
    ..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SharedPrefs.getApiToken();

          // Add header Authorization token
          if (token != null) {
            options.headers.addAll({'Authorization': 'Bearer $token'});
          }

          return handler.next(options);
        },
      ),
      PrettyDioLogger(
        request: true,
        error: true,
        compact: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: false,
      ),
    ]);

  // Dio
  getIt.registerSingleton<Dio>(dio);

  // API
  getIt.registerSingleton<AuthApi>(
    AuthApi(getIt()),
  );
  getIt.registerSingleton<InventoryApi>(
    InventoryApi(getIt()),
  );

  // Repositories
  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(getIt()),
  );
  getIt.registerSingleton<InventoryImpl>(
    InventoryImpl(getIt()),
  );

  // Use cases
  getIt.registerSingleton<SignInUseCase>(
    SignInUseCase(getIt()),
  );
  getIt.registerSingleton<InventoryUseCase>(InventoryUseCase(getIt()));

  // Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt()),
  );
}
