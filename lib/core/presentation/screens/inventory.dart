import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/usecases/warehouse/get_warehouse.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/inventory_template.dart';
import 'package:customer_app_mob/core/usecases/inventory/get_inventory.dart';
import 'package:customer_app_mob/core/dependencies.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController searchText = TextEditingController();
  List<Map<String, dynamic>> _inventortyFilterData = [];
  List<Map<String, dynamic>> _inventortyCacheData = [];
  List<String> _warehouseList = [];

  String _selectedCustomer = '';
  String _selectedWarehouse = '';
  int selectedBarIndex = 1;

  @override
  void initState() {
    super.initState();

    getWarehouseList();
  }

  @override
  void dispose() {
    super.dispose();

    searchText.dispose();
  }

  void generateData(String customerCode, String warehouse) async {
    if (customerCode.isNotEmpty && warehouse.isNotEmpty) {
      final data = await getIt<InventoryUseCase>().call(
          InventoryParams(customerCode: customerCode, warehouse: warehouse));

      if (data is DataSuccess) {
        final resp = data.resp!.data!;

        setState(() {
          _inventortyCacheData = resp;
          _inventortyFilterData = resp;
        });
      }
    }
  }

  void getWarehouseList() async {
    final warehouse = await getIt<WarehouseUseCase>().call(null);

    if (warehouse is DataSuccess) {
      setState(() {
        _warehouseList = warehouse.resp!.toList();
      });
    }
  }

  void onSearch(String searchValue) {
    if (_inventortyCacheData.isNotEmpty) {
      final filterData = _inventortyCacheData.where((elem) {
        return elem['materialCode']
            .toString()
            .toLowerCase()
            .contains(searchValue.toLowerCase());
      }).toList();

      setState(() {
        _inventortyFilterData = filterData;
      });
    }
  }

  void onClear() {
    searchText.clear();
    setState(() {
      _inventortyFilterData = _inventortyCacheData;
    });
  }

  void onTapCustomer(String customerCode) {
    setState(() {
      _selectedCustomer = customerCode;
    });
  }

  void onTapWarehouse(String warehouse) {
    setState(() {
      _selectedWarehouse = warehouse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InventoryTemplate(
      data: _inventortyFilterData,
      searchText: searchText,
      selectedBarIndex: selectedBarIndex,
      selectedCustomer: _selectedCustomer,
      selectedWarehouse: _selectedWarehouse,
      warehouseList: _warehouseList,
      generateData: generateData,
      onTapCustomer: onTapCustomer,
      onTapWarehouse: onTapWarehouse,
      onSearch: onSearch,
      onClear: onClear,
    );
  }
}
