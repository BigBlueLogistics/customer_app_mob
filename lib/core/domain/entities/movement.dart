import 'response.dart';

class MovementEntity extends ResponseEntity<List<TResponseData>> {
  const MovementEntity({super.data, super.message, super.status});
}

class MovementMaterialEntity extends ResponseEntity<List<TResponseData>> {
  const MovementMaterialEntity({super.data, super.message, super.status});
}
