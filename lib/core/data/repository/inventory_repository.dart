import 'dart:async';
import 'dart:io';

import 'package:customer_app_mob/core/data/data_sources/api/inventory/inventory_api.dart';
import 'package:customer_app_mob/core/data/models/inventory.dart';
import 'package:customer_app_mob/core/domain/repository/inventory_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:dio/dio.dart';

class InventoryImpl implements InventoryRepository {
  final InventoryApi _inventoryApi;

  InventoryImpl(this._inventoryApi);

  @override
  Future<DataState<InventoryModel>> inventory(InventoryParams params) async {
    try {
      final resp = await _inventoryApi.getInventory(
          params.customerCode, params.warehouse);

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
