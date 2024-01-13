import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:customer_app_mob/core/data/data_sources/api/auth_api.dart';
import 'package:customer_app_mob/core/data/repository/auth_repository.dart';
import 'package:customer_app_mob/core/domain/usecases/auth.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  getIt.registerSingleton<Dio>(Dio());

  // Dependencies
  getIt.registerSingleton<AuthApi>(
    AuthApi(getIt()),
  );

  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerSingleton<AuthUseCase>(
    AuthUseCase(getIt()),
  );

  // Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt()),
  );
}
