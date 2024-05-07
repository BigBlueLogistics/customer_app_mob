import 'package:customer_app_mob/core/data/repository/warehouse_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';
import 'package:dio/dio.dart';

class WarehouseUseCase implements UseCases<DataState<List<String>>, dynamic> {
  final WarehouseImpl _warehouseApi;

  WarehouseUseCase(this._warehouseApi);

  @override
  Future<DataState<List<String>>> call(params) async {
    try {
      final res = await _warehouseApi.getWarehouse();

      if (res is DataSuccess) {
        final list =
            List<String>.from(res.resp!.data!.map((e) => e['PLANT'])).toList();

        return DataSuccess(list);
      }

      return DataFailed(res.error as DioException);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
