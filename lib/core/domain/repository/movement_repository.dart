import 'package:customer_app_mob/core/data/models/movement.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class MovementRepository {
  Future<DataState<MovementModel>> movement(MovementParams params);

  Future<DataState<MovementMaterialModel>> materialDescription(
      String customerCode);
}

class MovementParams {
  MovementParams(
      {required this.customerCode,
      required this.warehouse,
      required this.materialCode,
      required this.movementType,
      required this.coverageDate});

  String customerCode;
  String warehouse;
  String movementType;
  String materialCode;
  List<String> coverageDate;
}
