import 'package:customer_app_mob/core/data/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/domain/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class GetScheduleTodayUseCase
    implements UseCases<DataState<TrucksVansEntity>, TrucksVansParams> {
  final TrucksVansImpl _reportRepository;

  GetScheduleTodayUseCase(this._reportRepository);

  @override
  Future<DataState<TrucksVansEntity>> call(params) {
    return _reportRepository.getScheduleToday(params!);
  }
}
