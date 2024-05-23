import 'package:customer_app_mob/core/data/repository/movement_repository.dart';
import 'package:customer_app_mob/core/domain/entities/movement.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class MovementMaterialUseCase
    implements UseCases<DataState<MovementMaterialEntity>, String> {
  final MovementImpl _movementRepository;

  MovementMaterialUseCase(this._movementRepository);

  @override
  Future<DataState<MovementMaterialEntity>> call(params) {
    return _movementRepository.materialDescription(params!);
  }
}
