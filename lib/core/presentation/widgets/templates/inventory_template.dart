import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search/md_search.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_filter/md_filter.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_table/md_datatable.dart';

class InventoryTemplate extends StatefulWidget {
  const InventoryTemplate({
    super.key,
    required this.data,
    required this.warehouseList,
    required this.searchText,
    required this.onTapCustomer,
    required this.onTapWarehouse,
    required this.selectedCustomer,
    required this.selectedWarehouse,
    required this.onSearch,
    required this.onClear,
    required this.generateData,
    this.selectedBarIndex = 0,
  });

  final List<Map<String, dynamic>> data;
  final List<String> warehouseList;
  final TextEditingController searchText;
  final ValueChanged<String> onTapCustomer;
  final ValueChanged<String> onTapWarehouse;
  final String selectedCustomer;
  final String selectedWarehouse;
  final ValueChanged<String> onSearch;
  final VoidCallback onClear;
  final void Function(String customerCode, String warehouse) generateData;
  final int selectedBarIndex;

  @override
  State<InventoryTemplate> createState() => _InventoryTemplateState();
}

class _InventoryTemplateState extends State<InventoryTemplate> {
  final GlobalKey widgetKey = GlobalKey();

  @override
  void didUpdateWidget(covariant InventoryTemplate oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedCustomer != widget.selectedCustomer) {
      widget.generateData(widget.selectedCustomer, 'BB05');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return MDScaffold(
      appBarTitle: 'Inventory',
      selectedBarIndex: widget.selectedBarIndex,
      body: SingleChildScrollView(
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

  MDFilter Filter(BuildContext context, Size mediaSize) {
    final authState = context.watch<AuthBloc>().state;
    final customerList =
        List<String>.from(authState.user.data!['user']['companies']).toList();

    return MDFilter(
      selectedCustomer: widget.selectedCustomer,
      onSelectCustomer: () {
        assert(debugCheckHasMediaQuery(context));

        showModalBottomSheet<void>(
            showDragHandle: true,
            context: context,
            isDismissible: true,
            builder: (BuildContext context) {
              return SizedBox(
                height: mediaSize.height * 0.30,
                child: ListView.builder(
                  itemCount: customerList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(customerList[index]),
                      onTap: () => widget.onTapCustomer(customerList[index]),
                      enabled: widget.selectedCustomer == customerList[index]
                          ? false
                          : true,
                      leading: widget.selectedCustomer == customerList[index]
                          ? const Icon(
                              Icons.check,
                            )
                          : null,
                    );
                  },
                ),
              );
            });
      },
      onFilter: () {
        showModalBottomSheet<void>(
            isDismissible: true,
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: mediaSize.height * 0.30,
                child: ListView.builder(
                  itemCount: widget.warehouseList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.warehouseList[index]),
                      onTap: () =>
                          widget.onTapWarehouse(widget.warehouseList[index]),
                      enabled: widget.selectedWarehouse ==
                              widget.warehouseList[index]
                          ? false
                          : true,
                      leading: widget.selectedWarehouse ==
                              widget.warehouseList[index]
                          ? const Icon(
                              Icons.check,
                            )
                          : null,
                    );
                  },
                ),
              );
            });
      },
      menuList: [
        MenuItemButton(
          onPressed: () {},
          child: const Text('Export excel'),
        ),
        MenuItemButton(
          onPressed: () {},
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
            onClear: widget.onClear,
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
                  onPressed: () =>
                      widget.generateData(widget.selectedCustomer, 'BB05'),
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
}
