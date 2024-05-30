import 'package:customer_app_mob/core/domain/entities/reports.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class ReportsRepository {
  Future<DataState<ReportsEntity>> getReports(ReportsParams params);
}

class ReportsParams {
  const ReportsParams({
    required this.customerCode,
    required this.reportType,
    required this.warehouse,
    required this.groupType,
  });

  final String customerCode;
  final String reportType;
  final String warehouse;
  final String groupType;
}
