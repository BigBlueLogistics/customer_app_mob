import 'package:customer_app_mob/core/data/repository/reports_repository.dart';
import 'package:customer_app_mob/core/domain/entities/reports.dart';
import 'package:customer_app_mob/core/domain/repository/reports_repository.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class ReportsUseCase
    implements UseCases<DataState<ReportsEntity>, ReportsParams> {
  final ReportsImpl _reportRepository;

  ReportsUseCase(this._reportRepository);

  @override
  Future<DataState<ReportsEntity>> call(params) {
    return _reportRepository.getReports(params!);
  }
}
