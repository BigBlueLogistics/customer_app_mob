import 'package:customer_app_mob/core/data/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/domain/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class GetStatusDetailsUseCase
    implements
        UseCases<DataState<TrucksVansStatusDetailsEntity>,
            TrucksVansStatusDetailsParams> {
  final TrucksVansImpl _reportRepository;

  GetStatusDetailsUseCase(this._reportRepository);

  @override
  Future<DataState<TrucksVansStatusDetailsEntity>> call(params) {
    return _reportRepository.getStatusDetails(params!);
  }
}
