import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/warehouse.dart';

part 'warehouse_api.g.dart';

@RestApi()
abstract class WarehouseApi {
  factory WarehouseApi(Dio dio) = _WarehouseApi;

  @GET('/warehouse/list')
  Future<HttpResponse<WarehouseModel>> getWarehouse();
}
