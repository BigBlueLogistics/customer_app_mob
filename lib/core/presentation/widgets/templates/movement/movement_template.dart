import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search/md_search.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_filter/md_filter.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_datatable/md_datatable.dart';
import 'package:customer_app_mob/core/presentation/screens/movement/data/data.dart';
import 'modal_filter_content.dart';

class MovementTemplate extends StatelessWidget {
  const MovementTemplate({
    super.key,
    required this.data,
    required this.searchText,
    required this.onSearch,
    required this.onClearData,
    required this.generateData,
    required this.filteringData,
    required this.warehouseList,
    required this.movementTypeList,
    required this.onFilterData,
    required this.onSelectCustomer,
    required this.onSelectWarehouse,
    required this.onSelectMovementType,
    required this.onExportFile,
    required this.onSelectMaterial,
    required this.onSelectCoverageDate,
  });

  final List<Map<String, dynamic>> data;
  final TextEditingController searchText;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearData;
  final VoidCallback generateData;
  final ValueNotifier<FilterValueNotifier> filteringData;
  final List<String> warehouseList;
  final List<String> movementTypeList;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
  final ValueChanged<String> onSelectMovementType;
  final ValueChanged<String> onExportFile;
  final ValueChanged<String> onSelectMaterial;
  final ValueChanged<DateTimeRange> onSelectCoverageDate;
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
                movementTypeList: movementTypeList,
                filteringData: filteringData,
                onFilterData: onFilterData,
                onSelectMaterial: onSelectMaterial,
                onSelectCustomer: onSelectCustomer,
                onSelectWarehouse: onSelectWarehouse,
                onSelectMovementType: onSelectMovementType,
                onSelectCoverageDate: onSelectCoverageDate,
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
              Text('Movement Details',
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
          columns: const <MDDataTableColumns>[
            MDDataTableColumns(title: 'WAREHOUSE', accessorKey: 'warehouse'),
            MDDataTableColumns(
                title: 'MATERIAL CODE', accessorKey: 'materialCode'),
            MDDataTableColumns(
                title: 'DOCUMENT NO.', accessorKey: 'documentNo'),
            MDDataTableColumns(title: 'TYPE', accessorKey: 'movementType'),
            MDDataTableColumns(
                title: 'DESCRIPTION', accessorKey: 'description'),
            MDDataTableColumns(title: 'BATCH', accessorKey: 'batch'),
            MDDataTableColumns(title: 'EXPIRATION', accessorKey: 'expiration'),
            MDDataTableColumns(title: 'QUANTITY', accessorKey: 'quantity'),
            MDDataTableColumns(title: 'UNIT', accessorKey: 'unit'),
            MDDataTableColumns(title: 'WEIGHT', accessorKey: 'weight'),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);

    return MDScaffold(
      appBarTitle: 'Movement',
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
