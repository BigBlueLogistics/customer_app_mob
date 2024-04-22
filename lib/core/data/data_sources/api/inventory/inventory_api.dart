import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/inventory.dart';

part 'inventory_api.g.dart';

@RestApi()
abstract class InventoryApi {
  factory InventoryApi(Dio dio) = _InventoryApi;

  @GET('/inventory')
  Future<HttpResponse<InventoryModel>> getInventory(
      @Query('customer_code') String customerCode,
      @Query('warehouse') String warehouse);
}
