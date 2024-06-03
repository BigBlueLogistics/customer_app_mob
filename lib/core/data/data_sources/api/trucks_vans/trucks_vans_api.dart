import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/trucks_vans.dart';

part 'trucks_vans_api.g.dart';

@RestApi()
abstract class TrucksVansApi {
  factory TrucksVansApi(Dio dio) = _TrucksVansApi;

  @GET('/trucks-vans/schedule-today')
  Future<HttpResponse<TrucksVansModel>> getScheduleToday(
    @Query('customerCode') String customerCode,
  );
  @GET('/trucks-vans/status')
  Future<HttpResponse<TrucksVansModel>> getTrucksVansStatus(
    @Query('customerCode') String customerCode,
  );
}
