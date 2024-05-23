import 'dart:async';
import 'dart:io';

import 'package:customer_app_mob/core/data/data_sources/api/warehouse/warehouse_api.dart';
import 'package:customer_app_mob/core/data/models/warehouse.dart';
import 'package:customer_app_mob/core/domain/repository/warehouse_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:dio/dio.dart';

class WarehouseImpl implements WarehouseRepository {
  final WarehouseApi _warehouseApi;

  WarehouseImpl(this._warehouseApi);

  @override
  Future<DataState<WarehouseModel>> getWarehouse() async {
    try {
      final resp = await _warehouseApi.getWarehouse();

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
