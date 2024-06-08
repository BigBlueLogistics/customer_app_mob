import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:customer_app_mob/core/data/data_sources/api/trucks_vans/trucks_vans_api.dart';
import 'package:customer_app_mob/core/data/models/trucks_vans.dart';
import 'package:customer_app_mob/core/domain/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

class TrucksVansImpl implements TrucksVansRepository {
  final TrucksVansApi _trucksVansApi;

  TrucksVansImpl(this._trucksVansApi);

  @override
  Future<DataState<TrucksVansModel>> getScheduleToday(
      TrucksVansParams params) async {
    try {
      final resp = await _trucksVansApi.getScheduleToday(params.customerCode);

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
  Future<DataState<TrucksVansModel>> getTrucksVansStatus(
      TrucksVansParams params) async {
    try {
      final resp =
          await _trucksVansApi.getTrucksVansStatus(params.customerCode);

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
  Future<DataState<TrucksVansStatusDetailsModel>> getStatusDetails(
      TrucksVansStatusDetailsParams params) async {
    try {
      final resp = await _trucksVansApi.getStatusDetails(
          params.customerCode, params.vanMonitorNo, params.action);

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
