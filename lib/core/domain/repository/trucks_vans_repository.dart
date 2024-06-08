import 'package:customer_app_mob/core/data/models/trucks_vans.dart';
import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class TrucksVansRepository {
  Future<DataState<TrucksVansModel>> getScheduleToday(TrucksVansParams params);
  Future<DataState<TrucksVansModel>> getTrucksVansStatus(
      TrucksVansParams params);
  Future<DataState<TrucksVansStatusDetailsModel>> getStatusDetails(
      TrucksVansStatusDetailsParams params);
}

class TrucksVansParams {
  const TrucksVansParams({
    required this.customerCode,
  });

  final String customerCode;
}

class TrucksVansStatusDetailsParams {
  const TrucksVansStatusDetailsParams({
    required this.customerCode,
    required this.vanMonitorNo,
    required this.action,
  });

  final String customerCode;
  final String vanMonitorNo;
  final String action;
}
