import 'package:customer_app_mob/core/domain/entities/indicators.dart';
import 'package:customer_app_mob/core/domain/repository/indicators_repository.dart';
import 'package:customer_app_mob/core/data/repository/indicators_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class GetActiveSkuUseCase
    implements
        UseCases<DataState<IndicatorsStatisticsEntity>, IndicatorsParams> {
  final IndicatorsImpl _indicatorsImpl;

  const GetActiveSkuUseCase(this._indicatorsImpl);

  @override
  Future<DataState<IndicatorsStatisticsEntity>> call(params) {
    return _indicatorsImpl.getActiveSku(params!);
  }
}
