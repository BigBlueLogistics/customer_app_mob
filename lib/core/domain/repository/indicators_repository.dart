import 'package:customer_app_mob/core/data/models/indicators.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class IndicatorsRepository {
  Future<DataState<IndicatorsStatisticsModel>> getActiveSku(
      IndicatorsParams params);
  Future<DataState<IndicatorsChartsModel>> getInOutbound(
      IndicatorsParams params);
}

class IndicatorsParams {
  const IndicatorsParams({
    required this.customerCode,
  });

  final String customerCode;
}
