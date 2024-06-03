import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class TrucksVansRepository {
  Future<DataState<TrucksVansEntity>> getScheduleToday(TrucksVansParams params);
  Future<DataState<TrucksVansEntity>> getTrucksVansStatus(
      TrucksVansParams params);
}

class TrucksVansParams {
  const TrucksVansParams({
    required this.customerCode,
  });

  final String customerCode;
}
