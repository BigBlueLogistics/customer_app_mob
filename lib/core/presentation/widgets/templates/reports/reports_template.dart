import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/button_segmented.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search/md_search.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_filter/md_filter.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_datatable/md_datatable.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/reports/modal_filter_content.dart';
import './notifier.dart';

class ReportsTemplate extends StatelessWidget {
  const ReportsTemplate({
    super.key,
    required this.data,
    required this.searchText,
    required this.onSearch,
    required this.columnSnapshot,
    required this.columnAging,
    required this.onClearData,
    required this.generateData,
    required this.filteringData,
    required this.warehouseList,
    required this.reportTypeList,
    required this.getGroupByOptions,
    required this.onFilterData,
    required this.onSelectCustomer,
    required this.onSelectWarehouse,
    required this.onSelectReportType,
    required this.onSelectGroupType,
    required this.onExportFile,
  });

  final List<Map<String, dynamic>> data;
  final TextEditingController searchText;
  final ValueChanged<String> onSearch;
  final List<MDDataTableColumns> Function(SegmentedValueMap? groupBy)
      columnSnapshot;
  final List<MDDataTableColumns> Function(SegmentedValueMap? groupBy)
      columnAging;
  final VoidCallback onClearData;
  final VoidCallback generateData;
  final ValueNotifier<FilterValueNotifier> filteringData;
  final List<String> warehouseList;
  final List<SegmentedValueMap> reportTypeList;
  final List<SegmentedValueMap> Function(SegmentedValueMap value)
      getGroupByOptions;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
  final ValueChanged<SegmentedValueMap> onSelectReportType;
  final ValueChanged<SegmentedValueMap> onSelectGroupType;
  final ValueChanged<String> onExportFile;
  final VoidCallback onFilterData;

  MDFilter Filter(BuildContext context, Size mediaSize) {
    final authState = context.watch<AuthBloc>().state;
    final customerList =
        List<String>.from(authState.user.data!['user']['companies']).toList();

    return MDFilter(
      selectedCustomer: filteringData.value.customerCode,
      onFilter: () {
        showModalBottomSheet<void>(
            isDismissible: true,
            showDragHandle: true,
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            scrollControlDisabledMaxHeightRatio: 1,
            builder: (BuildContext context) {
              return ModalFilterContent(
                customerList: customerList,
                warehouseList: warehouseList,
                reportTypeList: reportTypeList,
                getGroupByOptions: getGroupByOptions,
                filteringData: filteringData,
                onFilterData: onFilterData,
                onSelectCustomer: onSelectCustomer,
                onSelectWarehouse: onSelectWarehouse,
                onSelectReportType: onSelectReportType,
                onSelectGroupType: onSelectGroupType,
                onClearFilter: onClearData,
              );
            });
      },
      menuList: [
        MenuItemButton(
          onPressed: () => onExportFile('xlsx'),
          child: const Text('Export excel'),
        ),
        MenuItemButton(
          onPressed: () => onExportFile('csv'),
          child: const Text('Export csv'),
        ),
      ],
    );
  }

  Padding TableMovement(BuildContext context, Size mediaSize) {
    final filter = filteringData.value;

    log('filter.groupType ${filter.groupType.value}');
    log('filter.reportType ${filter.reportType.value}');

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: mediaSize.height * 0.05, bottom: 12.0),
          child: MDSearch(
            textController: searchText,
            onInputChanged: onSearch,
            onClear: onClearData,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reports Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500, letterSpacing: -0.6)),
              SizedBox(
                width: 28.0,
                height: 28.0,
                child: IconButton(
                  tooltip: 'Refresh',
                  padding: EdgeInsets.zero,
                  iconSize: 20.0,
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: generateData,
                ),
              )
            ],
          ),
        ),
        MDDataTable(
          rowsPerPage: 5,
          dataSource: data,
          columns: filter.reportType != SegmentedValueMap.empty &&
                  filter.reportType.value.toString() == 'wh-snapshot'
              ? columnSnapshot(filter.groupType)
              : columnAging(filter.groupType),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);

    return MDScaffold(
      appBarTitle: 'Reports',
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Filter(context, mediaSize),
            TableMovement(context, mediaSize),
          ],
        ),
      ),
    );
  }
}
