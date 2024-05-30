import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/inventory/notifier.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/inventory/modal_filter_content.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search/md_search.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_filter/md_filter.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_datatable/md_datatable.dart';

class InventoryTemplate extends StatelessWidget {
  const InventoryTemplate({
    super.key,
    required this.data,
    required this.warehouseList,
    required this.searchText,
    required this.filteringData,
    required this.generateData,
    required this.onSearch,
    required this.onClearData,
    required this.onFilterData,
    required this.onExportFile,
    required this.onSelectCustomer,
    required this.onSelectWarehouse,
  });

  final List<Map<String, dynamic>> data;
  final List<String> warehouseList;
  final TextEditingController searchText;
  final ValueChanged<String> onSearch;
  final ValueNotifier<FilterValueNotifier> filteringData;
  final VoidCallback generateData;
  final VoidCallback onClearData;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
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
            builder: (BuildContext context) {
              return ModalFilterContent(
                customerList: customerList,
                warehouseList: warehouseList,
                filteringData: filteringData,
                onFilterData: onFilterData,
                onSelectCustomer: onSelectCustomer,
                onSelectWarehouse: onSelectWarehouse,
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

  Padding TableInventory(BuildContext context, Size mediaSize) {
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
              Text('Material Details',
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
                title: 'DESCRIPTION', accessorKey: 'description'),
            MDDataTableColumns(title: 'FIXED WEIGHT', accessorKey: 'fixedWt'),
            MDDataTableColumns(
                title: 'AVAILABLE STOCKS', accessorKey: 'availableQty'),
            MDDataTableColumns(
                title: 'ALLOCATED STOCKS', accessorKey: 'allocatedQty'),
            MDDataTableColumns(
                title: 'RESTRICTED STOCKS', accessorKey: 'restrictedQty'),
            MDDataTableColumns(title: 'TOTAL STOCKS', accessorKey: 'totalQty'),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);

    return MDScaffold(
      appBarTitle: 'Inventory',
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Filter(context, mediaSize),
            TableInventory(context, mediaSize),
          ],
        ),
      ),
    );
  }
}
