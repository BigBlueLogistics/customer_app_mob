import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/movement.dart';

part 'movement_api.g.dart';

@RestApi()
abstract class MovementApi {
  factory MovementApi(Dio dio) = _MovementApi;

  @GET('/movements')
  Future<HttpResponse<MovementModel>> getMovement(
    @Query('customerCode') String customerCode,
    @Query('movementType') String movementType,
    @Query('materialCode') String materialCode,
    @Query('warehouseNo') String warehouse,
    @Query('coverageDate[]') List<String> coverageDate,
  );

  @GET('/movements/material-description')
  Future<HttpResponse<MovementMaterialModel>> getMaterialDescription(
      @Query('customer_code') String customerCode);
}
