import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/domain/repository/reports_repository.dart';
import 'package:customer_app_mob/core/usecases/reports/get_reports.dart';
import 'package:customer_app_mob/core/usecases/warehouse/get_warehouse.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/button_segmented.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_download/md_download_progress.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/reports/reports_template.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'data/data.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final TextEditingController searchText = TextEditingController();
  final ValueNotifier<FilterValueNotifier> _filteringData =
      ValueNotifier(FilterValueNotifier.empty);

  List<Map<String, dynamic>> _reportCacheData = [];
  List<Map<String, dynamic>> _reportFilterData = [];
  List<String> _warehouseList = [];
  List<String> customerList = [];
  LoadingStatus _warehouseStatus = LoadingStatus.idle;
  LoadingStatus _reportStatus = LoadingStatus.idle;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final authState = context.watch<AuthBloc>().state;

      if (authState.user != UserModel.empty) {
        customerList =
            List<String>.from(authState.user.data!['user']['companies'])
                .toList();
        log('didChangeDependencies $customerList');
      }
    }
  }

  void generateData() async {
    if (_filteringData.value.customerCode != null &&
        _filteringData.value.warehouse != null &&
        _filteringData.value.groupType != SegmentedValueMap.empty &&
        _filteringData.value.reportType != SegmentedValueMap.empty) {
      setState(() => _reportStatus = LoadingStatus.loading);

      final data = await getIt<ReportsUseCase>().call(ReportsParams(
          customerCode: _filteringData.value.customerCode.toString(),
          warehouse: _filteringData.value.warehouse.toString(),
          groupType: _filteringData.value.groupType.value.toString(),
          reportType: _filteringData.value.reportType.value.toString()));

      if (data is DataSuccess) {
        final resp = data.resp!.data!;

        setState(() {
          _reportFilterData = resp;
          _reportCacheData = resp;
          _reportStatus = LoadingStatus.success;
        });
      } else {
        setState(() => _reportStatus = LoadingStatus.failed);
      }
    }
  }

  void onFilterData() {
    // Close filtering modal
    if (_filteringData.value.customerCode != null &&
        _filteringData.value.warehouse != null &&
        _filteringData.value.groupType != SegmentedValueMap.empty &&
        _filteringData.value.reportType != SegmentedValueMap.empty) {
      Navigator.of(context).pop();
    }
    generateData();
  }

  void getWarehouseList() async {
    if (mounted) {
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
  }

  void onSelectCustomer(String customerCode) {
    _filteringData.value =
        _filteringData.value.copyWith(customerCode: customerCode);
  }

  void onSelectWarehouse(String warehouse) {
    _filteringData.value = _filteringData.value.copyWith(warehouse: warehouse);
  }

  void onSelectReportType(SegmentedValueMap reportType) {
    _filteringData.value = _filteringData.value
        .copyWith(reportType: reportType, groupType: SegmentedValueMap.empty);
  }

  void onSelectGroupType(SegmentedValueMap groupType) {
    _filteringData.value = _filteringData.value.copyWith(groupType: groupType);
  }

  void onSearch(String searchValue) {
    if (_reportCacheData.isNotEmpty) {
      final filterData = _reportCacheData.where((elem) {
        if (searchValue.trim().isNotEmpty) {
          return elem.values
              .toList()
              .map((e) => e.toString().toLowerCase())
              .contains(searchValue.toLowerCase());
        }
        return true;
      }).toList();

      setState(() {
        _reportFilterData = filterData;
      });
    }
  }

  void onClearData() {
    searchText.clear();
    _filteringData.value = FilterValueNotifier.empty;

    setState(() {
      _reportFilterData = [];
      _reportCacheData = [];
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
        _filteringData.value.groupType == SegmentedValueMap.empty ||
        _filteringData.value.reportType == SegmentedValueMap.empty) {
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
          final groupType = _filteringData.value.groupType.value;
          final reportType = _filteringData.value.reportType.value;
          String filename =
              '$reportType-$customer-$groupType-$warehouse.$format';
          final queryParameters = {
            'customer_code': customer,
            'group_type': groupType,
            'warehouse': warehouse,
            'report_type': reportType,
            'format': format
          };

          return MDDownloadProgress(
              filename: filename,
              url: '/reports/export-excel',
              queryParameters: queryParameters);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ReportsTemplate(
          data: _reportFilterData,
          searchText: searchText,
          filteringData: _filteringData,
          warehouseList: _warehouseList,
          customerList: customerList,
          reportTypeList: reportTypeList,
          getGroupByOptions: getGroupByOptions,
          generateData: generateData,
          columnSnapshot: columnSnapshot,
          columnAging: columnAging,
          onSearch: onSearch,
          onClearData: onClearData,
          onFilterData: onFilterData,
          onSelectCustomer: onSelectCustomer,
          onSelectWarehouse: onSelectWarehouse,
          onSelectReportType: onSelectReportType,
          onSelectGroupType: onSelectGroupType,
          onExportFile: onExportFile,
        ),
        MDLoadingFullScreen(
            isLoading: _warehouseStatus == LoadingStatus.loading ||
                _reportStatus == LoadingStatus.loading)
      ],
    );
  }
}
