import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/button_segmented.dart';

class FilterValueNotifier {
  const FilterValueNotifier({
    this.customerCode,
    this.warehouse,
    this.reportType = SegmentedValueMap.empty,
    this.groupType = SegmentedValueMap.empty,
  });

  final String? customerCode;
  final String? warehouse;
  final SegmentedValueMap reportType;
  final SegmentedValueMap groupType;

  FilterValueNotifier copyWith({
    String? customerCode,
    String? warehouse,
    SegmentedValueMap? reportType,
    SegmentedValueMap? groupType,
  }) {
    return FilterValueNotifier(
      customerCode: customerCode ?? this.customerCode,
      warehouse: warehouse ?? this.warehouse,
      reportType: reportType ?? this.reportType,
      groupType: groupType ?? this.groupType,
    );
  }

  static const empty = FilterValueNotifier();
}
