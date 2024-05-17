import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/widgets/modal_filter_content.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search/md_search.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_filter/md_filter.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_datatable/md_datatable.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_download/md_download_progress.dart';
import 'package:customer_app_mob/core/utils/log.dart';

class InventoryTemplate extends StatefulWidget {
  const InventoryTemplate({
    super.key,
    required this.data,
    required this.warehouseList,
    required this.searchText,
    required this.onSearch,
    required this.onClearData,
    required this.generateData,
  });

  final List<Map<String, dynamic>> data;
  final List<String> warehouseList;
  final TextEditingController searchText;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearData;
  final void Function({required String customerCode, required String warehouse})
      generateData;

  @override
  State<InventoryTemplate> createState() => _InventoryTemplateState();
}

class _InventoryTemplateState extends State<InventoryTemplate> {
  String _selectedCustomer = '';
  String _selectedWarehouse = '';

  void onSelectCustomer(String customerCode, StateSetter setState) {
    setState(() {
      _selectedCustomer = customerCode;
    });
  }

  void onSelectWarehouse(String warehouse, StateSetter setState) {
    setState(() {
      _selectedWarehouse = warehouse;
    });
  }

  void onClearFilter(StateSetter setState) {
    setState(() {
      _selectedCustomer = '';
      _selectedWarehouse = '';
    });
    widget.onClearData();
  }

  void onFilterData() {
    Navigator.of(context).pop();
    widget.generateData(
        customerCode: _selectedCustomer, warehouse: _selectedWarehouse);
  }

  Future<bool> permissionRequest() async {
    PermissionStatus result;
    result = await Permission.manageExternalStorage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  void downloadFile(String format) async {
    if (_selectedCustomer.isEmpty || _selectedWarehouse.isEmpty) {
      return;
    }

    bool result = await permissionRequest();
    if (!result) {
      log('No permission to read and write.');
    }

    if (!mounted) {
      return;
    }
    showDialog(
        context: context,
        builder: (dialogcontext) {
          String filename =
              'INVENTORY-$_selectedCustomer-$_selectedWarehouse.$format';
          final queryParameters = {
            'customer_code': _selectedCustomer,
            'warehouse': _selectedWarehouse,
            'format': format
          };

          return MDDownloadProgress(
              filename: filename,
              url: '/inventory/export-excel',
              queryParameters: queryParameters);
        });
  }

  MDFilter Filter(BuildContext context, Size mediaSize) {
    final authState = context.watch<AuthBloc>().state;
    final customerList =
        List<String>.from(authState.user.data!['user']['companies']).toList();

    return MDFilter(
      selectedCustomer: _selectedCustomer,
      onFilter: () {
        showModalBottomSheet<void>(
            isDismissible: true,
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return ModalFilterContent(
                    customerList: customerList,
                    warehouseList: widget.warehouseList,
                    selectedCustomer: _selectedCustomer,
                    selectedWarehouse: _selectedWarehouse,
                    onFilterData: onFilterData,
                    onSelectCustomer: (String customer) =>
                        onSelectCustomer(customer, setState),
                    onSelectWarehouse: (String warehouse) =>
                        onSelectWarehouse(warehouse, setState),
                    onClearFilter: () => onClearFilter(setState),
                  );
                },
              );
            });
      },
      menuList: [
        MenuItemButton(
          onPressed: () => downloadFile('xlsx'),
          child: const Text('Export excel'),
        ),
        MenuItemButton(
          onPressed: () => downloadFile('csv'),
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
            textController: widget.searchText,
            onInputChanged: widget.onSearch,
            onClear: widget.onClearData,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Material Details',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.6,
                    ),
              ),
              SizedBox(
                width: 28.0,
                height: 28.0,
                child: IconButton(
                  tooltip: 'Refresh',
                  padding: EdgeInsets.zero,
                  iconSize: 20.0,
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () => widget.generateData(
                      customerCode: _selectedCustomer,
                      warehouse: _selectedWarehouse),
                ),
              )
            ],
          ),
        ),
        MDDataTable(
          rowsPerPage: 5,
          dataSource: widget.data,
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
    final mediaSize = MediaQuery.of(context).size;

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
