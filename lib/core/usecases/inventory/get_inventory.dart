import 'package:customer_app_mob/core/data/repository/inventory_repository.dart';
import 'package:customer_app_mob/core/domain/entities/inventory.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class InventoryParams {
  String customerCode;
  String warehouse;

  InventoryParams({required this.customerCode, required this.warehouse});
}

class InventoryUseCase
    implements UseCases<DataState<InventoryEntity>, InventoryParams> {
  final InventoryImpl _inventoryRepository;

  InventoryUseCase(this._inventoryRepository);

  @override
  Future<DataState<InventoryEntity>> call(params) {
    return _inventoryRepository.inventory(
        customerCode: params.customerCode, warehouse: params.warehouse);
  }
}
