import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:customer_app_mob/core/data/models/reports.dart';

part 'reports_api.g.dart';

@RestApi()
abstract class ReportsApi {
  factory ReportsApi(Dio dio) = _ReportsApi;

  @GET('/reports')
  Future<HttpResponse<ReportsModel>> getReports(
    @Query('customer_code') String customerCode,
    @Query('report_type') String reportType,
    @Query('warehouse') String warehouse,
    @Query('group_by') String groupBy,
  );
}
