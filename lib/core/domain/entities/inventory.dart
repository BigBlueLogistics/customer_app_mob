import 'response.dart';

class InventoryEntity extends ResponseEntity<List<TResponseData>> {
  const InventoryEntity({super.status, super.data, super.message});
}
