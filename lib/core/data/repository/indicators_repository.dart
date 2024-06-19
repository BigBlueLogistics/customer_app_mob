import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:customer_app_mob/core/data/data_sources/api/indicators/indicators_api.dart';
import 'package:customer_app_mob/core/data/models/indicators.dart';
import 'package:customer_app_mob/core/domain/repository/indicators_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

class IndicatorsImpl implements IndicatorsRepository {
  final IndicatorsApi _indicatorsApi;

  IndicatorsImpl(this._indicatorsApi);

  @override
  Future<DataState<IndicatorsStatisticsModel>> getActiveSku(
      IndicatorsParams params) async {
    try {
      final resp = await _indicatorsApi.getActiveSku(params.customerCode);

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

  @override
  Future<DataState<IndicatorsChartsModel>> getInOutbound(
      IndicatorsParams params) async {
    try {
      final resp = await _indicatorsApi.getInOutbound(params.customerCode);

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
