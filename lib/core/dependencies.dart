import 'package:customer_app_mob/core/usecases/trucks_vans/get_status_details.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:customer_app_mob/config/dio/auth_interceptor.dart';
import 'package:customer_app_mob/config/constants/url.dart';
import 'package:customer_app_mob/core/data/data_sources/api/movement/movement_api.dart';
import 'package:customer_app_mob/core/data/repository/movement_repository.dart';
import 'package:customer_app_mob/core/usecases/movement/get_material.dart';
import 'package:customer_app_mob/core/usecases/movement/get_movement.dart';
import 'package:customer_app_mob/core/data/data_sources/api/warehouse/warehouse_api.dart';
import 'package:customer_app_mob/core/data/repository/warehouse_repository.dart';
import 'package:customer_app_mob/core/usecases/warehouse/get_warehouse.dart';
import 'package:customer_app_mob/core/data/data_sources/api/inventory/inventory_api.dart';
import 'package:customer_app_mob/core/data/repository/inventory_repository.dart';
import 'package:customer_app_mob/core/usecases/inventory/get_inventory.dart';
import 'package:customer_app_mob/core/data/data_sources/api/auth/auth_api.dart';
import 'package:customer_app_mob/core/data/repository/auth_repository.dart';
import 'package:customer_app_mob/core/usecases/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/data/data_sources/api/reports/reports_api.dart';
import 'package:customer_app_mob/core/data/repository/reports_repository.dart';
import 'package:customer_app_mob/core/usecases/reports/get_reports.dart';
import 'package:customer_app_mob/core/data/data_sources/api/trucks_vans/trucks_vans_api.dart';
import 'package:customer_app_mob/core/data/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_schedule_today.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_trucks_vans_status.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio()
    ..options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(minutes: 1),
      baseUrl: AppConstant.apiUrl,
      headers: {
        'Accept': 'application/json',
      },
    )
    // Dio log http request
    ..interceptors.addAll([
      AuthInterceptor(),
      PrettyDioLogger(
        request: true,
        error: true,
        compact: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    ]);

  // Dio
  getIt.registerSingleton<Dio>(dio);

  // API
  getIt.registerSingleton<AuthApi>(AuthApi(getIt()));
  getIt.registerSingleton<InventoryApi>(InventoryApi(getIt()));
  getIt.registerSingleton<WarehouseApi>(WarehouseApi(getIt()));
  getIt.registerSingleton<MovementApi>(MovementApi(getIt()));
  getIt.registerSingleton<ReportsApi>(ReportsApi(getIt()));
  getIt.registerSingleton<TrucksVansApi>(TrucksVansApi(getIt()));

  // Repositories
  getIt.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl(getIt()));
  getIt.registerSingleton<InventoryImpl>(InventoryImpl(getIt()));
  getIt.registerSingleton<WarehouseImpl>(WarehouseImpl(getIt()));
  getIt.registerSingleton<MovementImpl>(MovementImpl(getIt()));
  getIt.registerSingleton<ReportsImpl>(ReportsImpl(getIt()));
  getIt.registerSingleton<TrucksVansImpl>(TrucksVansImpl(getIt()));

  // Use cases
  getIt.registerSingleton<SignInUseCase>(SignInUseCase(getIt()));
  getIt.registerSingleton<InventoryUseCase>(InventoryUseCase(getIt()));
  getIt.registerSingleton<WarehouseUseCase>(WarehouseUseCase(getIt()));
  getIt.registerSingleton<MovementUseCase>(MovementUseCase(getIt()));
  getIt.registerSingleton<MovementMaterialUseCase>(
      MovementMaterialUseCase(getIt()));
  getIt.registerSingleton<ReportsUseCase>(ReportsUseCase(getIt()));
  getIt.registerSingleton<GetScheduleTodayUseCase>(
      GetScheduleTodayUseCase(getIt()));
  getIt.registerSingleton<GetTrucksVansStatusUseCase>(
      GetTrucksVansStatusUseCase(getIt()));
  getIt.registerSingleton<GetStatusDetailsUseCase>(
      GetStatusDetailsUseCase(getIt()));

  // Bloc
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt()));
}
