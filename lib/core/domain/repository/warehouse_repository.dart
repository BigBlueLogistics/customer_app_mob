import 'package:customer_app_mob/core/data/models/warehouse.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class WarehouseRepository {
  Future<DataState<WarehouseModel>> getWarehouse();
}
