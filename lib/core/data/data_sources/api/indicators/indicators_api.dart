import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/indicators.dart';

part 'indicators_api.g.dart';

@RestApi()
abstract class IndicatorsApi {
  factory IndicatorsApi(Dio dio) = _IndicatorsApi;

  @GET('/indicators/active-sku')
  Future<HttpResponse<IndicatorsStatisticsModel>> getActiveSku(
    @Query('customer_code') String customerCode,
  );

  @GET('/indicators/in-out-bound')
  Future<HttpResponse<IndicatorsChartsModel>> getInOutbound(
    @Query('customer_code') String customerCode,
  );
}
