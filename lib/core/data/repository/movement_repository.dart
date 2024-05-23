import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:customer_app_mob/core/data/data_sources/api/movement/movement_api.dart';
import 'package:customer_app_mob/core/data/models/movement.dart';
import 'package:customer_app_mob/core/domain/repository/movement_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

class MovementImpl implements MovementRepository {
  final MovementApi _movementApi;

  MovementImpl(this._movementApi);

  @override
  Future<DataState<MovementModel>> movement(MovementParams params) async {
    try {
      final resp = await _movementApi.getMovement(
          params.customerCode,
          params.movementType,
          params.materialCode,
          params.warehouse,
          params.coverageDate);

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
  Future<DataState<MovementMaterialModel>> materialDescription(
      String customerCode) async {
    try {
      final resp = await _movementApi.getMaterialDescription(customerCode);

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
