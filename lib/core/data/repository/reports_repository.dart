import 'dart:async';
import 'dart:io';

import 'package:customer_app_mob/core/data/data_sources/api/reports/reports_api.dart';
import 'package:customer_app_mob/core/data/models/reports.dart';
import 'package:customer_app_mob/core/domain/repository/reports_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:dio/dio.dart';

class ReportsImpl implements ReportsRepository {
  final ReportsApi _reportsApi;

  ReportsImpl(this._reportsApi);

  @override
  Future<DataState<ReportsModel>> getReports(ReportsParams params) async {
    try {
      final resp = await _reportsApi.getReports(params.customerCode,
          params.reportType, params.warehouse, params.groupType);

      if (resp.response.statusCode == HttpStatus.ok) {
        return DataSuccess(resp.data);
      }

      return DataFailed(DioException(
          requestOptions: resp.response.requestOptions,
          response: resp.response,
          message: resp.response.statusMessage));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
