import 'package:customer_app_mob/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/clear_button.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/filter_button.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/button_segmented.dart';
import 'notifier.dart';

class ModalFilterContent extends StatelessWidget {
  const ModalFilterContent({
    super.key,
    required this.customerList,
    required this.warehouseList,
    required this.reportTypeList,
    required this.getGroupByOptions,
    required this.filteringData,
    required this.onSelectCustomer,
    required this.onSelectWarehouse,
    required this.onSelectReportType,
    required this.onSelectGroupType,
    required this.onFilterData,
    required this.onClearFilter,
  });

  final List<String> customerList;
  final List<String> warehouseList;
  final List<SegmentedValueMap> reportTypeList;
  final List<SegmentedValueMap> Function(SegmentedValueMap value)
      getGroupByOptions;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
  final ValueChanged<SegmentedValueMap> onSelectReportType;
  final ValueChanged<SegmentedValueMap> onSelectGroupType;
  final VoidCallback onFilterData;
  final VoidCallback onClearFilter;
  final ValueNotifier<FilterValueNotifier> filteringData;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    const buttonBorderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    final segmentButtonStyles = SegmentedButton.styleFrom(
      side: BorderSide(color: Colors.grey.shade300),
      shape: buttonBorderShape,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        child: ValueListenableBuilder<FilterValueNotifier>(
          valueListenable: filteringData,
          builder: (context, value, child) {
            var column = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Customer:'),
                customerList.isNotEmpty
                    ? ButtonSegmented(
                        onSelectedChanged: (Set<String> newSelection) {
                          onSelectCustomer(newSelection.first);
                        },
                        dataList: customerList,
                        selectedValue: value.customerCode != null
                            ? value.customerCode.toString()
                            : '',
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 10),
                const Text('Warehouse:'),
                warehouseList.isNotEmpty
                    ? ButtonSegmented(
                        onSelectedChanged: (Set<String> newSelection) {
                          onSelectWarehouse(newSelection.first);
                        },
                        dataList: warehouseList,
                        selectedValue: value.warehouse != null
                            ? value.warehouse.toString()
                            : '',
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 10),
                const Text('Report Type:'),
                reportTypeList.isNotEmpty
                    ? ButtonSegmented<SegmentedValueMap>(
                        onSelectedChanged: (newSelection) {
                          onSelectReportType(newSelection.first);
                        },
                        dataList: reportTypeList,
                        selectedValue: value.reportType,
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 10),
                const Text('Group by:'),
                value.reportType != SegmentedValueMap.empty
                    ? ButtonSegmented<SegmentedValueMap>(
                        onSelectedChanged: (newSelection) {
                          onSelectGroupType(newSelection.first);
                        },
                        dataList: getGroupByOptions(value.reportType),
                        selectedValue: value.groupType,
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 15),
                FilterButton(
                    onPressed: customerList.isNotEmpty ? onFilterData : null),
                ClearButton(
                    onTap: customerList.isNotEmpty ? onClearFilter : null,
                    mediaSize: mediaSize)
              ],
            );

            return SingleChildScrollView(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: column,
            ));
          },
        ),
      ),
    );
  }
}
