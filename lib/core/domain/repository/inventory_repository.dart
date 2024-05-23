import 'package:customer_app_mob/core/data/models/inventory.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class InventoryRepository {
  Future<DataState<InventoryModel>> inventory(InventoryParams params);
}

class InventoryParams {
  String customerCode;
  String warehouse;

  InventoryParams({required this.customerCode, required this.warehouse});
}
