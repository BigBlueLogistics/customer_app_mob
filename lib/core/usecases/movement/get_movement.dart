import 'package:customer_app_mob/core/data/repository/movement_repository.dart';
import 'package:customer_app_mob/core/domain/entities/movement.dart';
import 'package:customer_app_mob/core/domain/repository/movement_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class MovementUseCase
    implements UseCases<DataState<MovementEntity>, MovementParams> {
  final MovementImpl _movementRepository;

  MovementUseCase(this._movementRepository);

  @override
  Future<DataState<MovementEntity>> call(params) {
    return _movementRepository.movement(params!);
  }
}
