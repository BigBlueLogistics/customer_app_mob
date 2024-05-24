import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/usecases/movement/get_material.dart';
import 'package:customer_app_mob/core/domain/repository/movement_repository.dart';
import 'package:customer_app_mob/core/usecases/movement/get_movement.dart';
import 'package:customer_app_mob/core/usecases/warehouse/get_warehouse.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/movement/movement_template.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_download/md_download_progress.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/movement/notifier.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class MovementScreen extends StatefulWidget {
  const MovementScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  final TextEditingController searchText = TextEditingController();
  final ValueNotifier<FilterValueNotifier> _filteringData =
      ValueNotifier(FilterValueNotifier.empty);

  List<Map<String, dynamic>> _movementCacheData = [];
  List<Map<String, dynamic>> _movementFilterData = [];
  List<String> _warehouseList = [];
  final List<String> _movementTypeList = ['all', 'inbound', 'outbound'];
  LoadingStatus _warehouseStatus = LoadingStatus.idle;
  LoadingStatus _materialStatus = LoadingStatus.idle;
  LoadingStatus _movementStatus = LoadingStatus.idle;

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
        _filteringData.value.warehouse != null &&
        _filteringData.value.materialCode != null &&
        _filteringData.value.movementType != null &&
        _filteringData.value.coverageDate != null) {
      setState(() => _movementStatus = LoadingStatus.loading);

      final data = await getIt<MovementUseCase>().call(MovementParams(
          customerCode: _filteringData.value.customerCode.toString(),
          warehouse: _filteringData.value.warehouse.toString(),
          materialCode: _filteringData.value.materialCode.toString(),
          movementType: _filteringData.value.movementType.toString(),
          coverageDate: _filteringData.value.coverageDate!.toList()));

      if (data is DataSuccess) {
        final resp = data.resp!.data!;

        setState(() {
          _movementFilterData = resp;
          _movementCacheData = resp;
          _movementStatus = LoadingStatus.success;
        });
      } else {
        setState(() => _movementStatus = LoadingStatus.failed);
      }
    }
  }

  void onFilterData() {
    // Close filtering modal
    if (_filteringData.value.customerCode != null &&
        _filteringData.value.warehouse != null &&
        _filteringData.value.materialCode != null &&
        _filteringData.value.movementType != null &&
        _filteringData.value.coverageDate != null) {
      Navigator.of(context).pop();
    }
    generateData();
  }

  void getWarehouseList() async {
    setState(() => _warehouseStatus = LoadingStatus.loading);
    final warehouse = await getIt<WarehouseUseCase>().call(null);

    if (warehouse is DataSuccess) {
      setState(() {
        _warehouseStatus = LoadingStatus.success;
        _warehouseList = warehouse.resp!.toList();
      });
    } else {
      setState(() => _warehouseStatus = LoadingStatus.failed);
    }
  }

  void getMaterialList(String customerCode) async {
    setState(() => _materialStatus = LoadingStatus.loading);
    final material = await getIt<MovementMaterialUseCase>().call(customerCode);

    if (material is DataSuccess) {
      _filteringData.value = _filteringData.value
          .copyWith(materialList: material.resp!.data!.toList());

      setState(() {
        _materialStatus = LoadingStatus.success;
      });
    } else {
      setState(() => _materialStatus = LoadingStatus.failed);
    }
  }

  void onSelectCustomer(String customerCode) {
    _filteringData.value = _filteringData.value
        .copyWith(customerCode: customerCode, materialList: []);

    // Fetch the material list.
    if (customerCode.isNotEmpty) {
      getMaterialList(customerCode);
    }
  }

  void onSelectWarehouse(String warehouse) {
    _filteringData.value = _filteringData.value.copyWith(warehouse: warehouse);
  }

  void onSelectMovementType(String movementType) {
    _filteringData.value =
        _filteringData.value.copyWith(movementType: movementType);
  }

  void onSelectMaterial(String material) {
    _filteringData.value =
        _filteringData.value.copyWith(materialCode: material);
  }

  void onSelectCoverageDate(DateTimeRange date) {
    final start = DateFormat('MM/dd/y').format(date.start);
    final end = DateFormat('MM/dd/y').format(date.end);

    _filteringData.value =
        _filteringData.value.copyWith(coverageDate: [start, end]);
  }

  void onSearch(String searchValue) {
    if (_movementCacheData.isNotEmpty) {
      final filterData = _movementCacheData.where((elem) {
        if (searchValue.trim().isNotEmpty) {
          return elem.values
              .toList()
              .map((e) => e.toString().toLowerCase())
              .contains(searchValue.toLowerCase());
        }
        return true;
      }).toList();

      setState(() {
        _movementFilterData = filterData;
      });
    }
  }

  void onClearData() {
    searchText.clear();
    _filteringData.value = FilterValueNotifier.empty;

    setState(() {
      _movementFilterData = [];
      _movementCacheData = [];
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
    // If one of the filtering value is empty, it can't export file.
    if (_filteringData.value.customerCode == null ||
        _filteringData.value.warehouse == null ||
        _filteringData.value.materialCode == null ||
        _filteringData.value.movementType == null ||
        _filteringData.value.coverageDate == null) {
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
          final material = _filteringData.value.materialCode;
          final movementType = _filteringData.value.movementType;
          final coverageDate = _filteringData.value.coverageDate;
          String filename = 'MOVEMENT-$customer-$warehouse.$format';
          final queryParameters = {
            'customerCode': customer,
            'materialCode': material,
            'warehouseNo': warehouse,
            'movementType': movementType,
            'coverageDate[]': coverageDate,
            'format': format
          };

          return MDDownloadProgress(
              filename: filename,
              url: '/movements/export-excel',
              queryParameters: queryParameters);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MovementTemplate(
          data: _movementFilterData,
          searchText: searchText,
          filteringData: _filteringData,
          warehouseList: _warehouseList,
          movementTypeList: _movementTypeList,
          generateData: generateData,
          onSearch: onSearch,
          onClearData: onClearData,
          onFilterData: onFilterData,
          onSelectCustomer: onSelectCustomer,
          onSelectWarehouse: onSelectWarehouse,
          onSelectMovementType: onSelectMovementType,
          onSelectMaterial: onSelectMaterial,
          onSelectCoverageDate: onSelectCoverageDate,
          onExportFile: onExportFile,
        ),
        MDLoadingFullScreen(
          isLoading: _warehouseStatus == LoadingStatus.loading ||
              _movementStatus == LoadingStatus.loading ||
              _materialStatus == LoadingStatus.loading,
        )
      ],
    );
  }
}
