import 'package:customer_app_mob/core/domain/entities/inventory.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class InventoryRepository {
  Future<DataState<Inventory>> inventory();
}
