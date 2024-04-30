import 'package:customer_app_mob/core/data/models/inventory.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class InventoryRepository {
  Future<DataState<InventoryModel>> inventory(
      {required String customerCode, required String warehouse});
}
