import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:customer_app_mob/core/domain/repository/inventory_repository.dart';
import 'package:customer_app_mob/core/usecases/warehouse/get_warehouse.dart';
import 'package:customer_app_mob/core/usecases/inventory/get_inventory.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_download/md_download_progress.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/inventory/notifier.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/inventory/inventory_template.dart';
import 'package:permission_handler/permission_handler.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController searchText = TextEditingController();
  final ValueNotifier<FilterValueNotifier> _filteringData =
      ValueNotifier(FilterValueNotifier.empty);

  List<Map<String, dynamic>> _inventoryCacheData = [];
  List<Map<String, dynamic>> _inventoryFilterData = [];
  List<String> _warehouseList = [];
  LoadingStatus _warehouseStatus = LoadingStatus.idle;
  LoadingStatus _inventoryStatus = LoadingStatus.idle;

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

  void generateData() async {
    if (_filteringData.value.customerCode != null &&
        _filteringData.value.warehouse != null) {
      setState(() => _inventoryStatus = LoadingStatus.loading);

      final data = await getIt<InventoryUseCase>().call(InventoryParams(
        customerCode: _filteringData.value.customerCode.toString(),
        warehouse: _filteringData.value.warehouse.toString(),
      ));

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

  void onFilterData() {
    // Close filtering modal
    if (_filteringData.value.customerCode != null &&
        _filteringData.value.warehouse != null) {
      Navigator.of(context).pop();
    }
    generateData();
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

  void onSelectCustomer(String customerCode) {
    _filteringData.value =
        _filteringData.value.copyWith(customerCode: customerCode);
  }

  void onSelectWarehouse(String warehouse) {
    _filteringData.value = _filteringData.value.copyWith(warehouse: warehouse);
  }

  void onClearData() {
    searchText.clear();
    _filteringData.value = FilterValueNotifier.empty;

    setState(() {
      _inventoryFilterData = [];
      _inventoryCacheData = [];
    });
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

  void onExportFile(String format) async {
    if (_filteringData.value.customerCode == null ||
        _filteringData.value.warehouse == null) {
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
          final customer = _filteringData.value.customerCode;
          final warehouse = _filteringData.value.warehouse;
          String filename = 'INVENTORY-$customer-$warehouse.$format';
          final queryParameters = {
            'customer_code': customer,
            'warehouse': warehouse,
            'format': format
          };

          return MDDownloadProgress(
              filename: filename,
              url: '/inventory/export-excel',
              queryParameters: queryParameters);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InventoryTemplate(
          data: _inventoryFilterData,
          searchText: searchText,
          warehouseList: _warehouseList,
          filteringData: _filteringData,
          generateData: generateData,
          onSearch: onSearch,
          onClearData: onClearData,
          onFilterData: onFilterData,
          onExportFile: onExportFile,
          onSelectCustomer: onSelectCustomer,
          onSelectWarehouse: onSelectWarehouse,
        ),
        MDLoadingFullScreen(
          isLoading: _warehouseStatus == LoadingStatus.loading ||
              _inventoryStatus == LoadingStatus.loading,
        )
      ],
    );
  }
}
