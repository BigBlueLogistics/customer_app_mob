import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
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

  List<Map<String, dynamic>> _inventoryCacheData = [];
  List<Map<String, dynamic>> _inventoryFilterData = [];
  List<String> _warehouseList = [];
  LoadingStatus _warehouseStatus = LoadingStatus.idle;
  LoadingStatus _inventoryStatus = LoadingStatus.idle;
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

  void generateData(
      {required String customerCode, required String warehouse}) async {
    if (customerCode.isNotEmpty && warehouse.isNotEmpty) {
      setState(() => _inventoryStatus = LoadingStatus.loading);

      final data = await getIt<InventoryUseCase>().call(
          InventoryParams(customerCode: customerCode, warehouse: warehouse));

      if (data is DataSuccess) {
        final resp = data.resp!.data!;

        setState(() {
          _inventoryFilterData = resp;
          _inventoryCacheData = resp;
          _inventoryStatus = LoadingStatus.success;
        });
      } else {
        setState(() => _inventoryStatus = LoadingStatus.failed);
      }
    }
  }

  void getWarehouseList() async {
    setState(() => _warehouseStatus = LoadingStatus.loading);
    final warehouse = await getIt<WarehouseUseCase>().call(null);

    if (warehouse is DataSuccess) {
      setState(() {
        _warehouseList = warehouse.resp!;

        _warehouseStatus = LoadingStatus.success;
      });
    } else {
      setState(() => _warehouseStatus = LoadingStatus.failed);
    }
  }

  void onSearch(String searchValue) {
    if (_inventoryCacheData.isNotEmpty) {
      final filterData = _inventoryCacheData.where((elem) {
        if (searchValue.trim().isNotEmpty) {
          return elem.values
              .toList()
              .map((e) => e.toString().toLowerCase())
              .contains(searchValue.toLowerCase());
        }
        return true;
      }).toList();

      setState(() {
        _inventoryFilterData = filterData;
      });
    }
  }

  void onClearData() {
    searchText.clear();

    setState(() {
      _inventoryFilterData = [];
      _inventoryCacheData = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InventoryTemplate(
          data: _inventoryFilterData,
          searchText: searchText,
          selectedBarIndex: selectedBarIndex,
          warehouseList: _warehouseList,
          generateData: generateData,
          onSearch: onSearch,
          onClearData: onClearData,
        ),
        MDLoadingFullScreen(
          isLoading: _warehouseStatus == LoadingStatus.loading ||
              _inventoryStatus == LoadingStatus.loading,
        )
      ],
    );
  }
}
