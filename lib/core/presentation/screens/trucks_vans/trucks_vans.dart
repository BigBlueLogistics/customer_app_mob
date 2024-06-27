import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/domain/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/trucks_vans/data/data.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_schedule_today.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_status_details.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_trucks_vans_status.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/trucks_vans/trucks_vans_template.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrucksVansScreen extends StatefulWidget {
  const TrucksVansScreen({super.key});

  @override
  State<TrucksVansScreen> createState() => _TrucksVansScreenState();
}

class _TrucksVansScreenState extends State<TrucksVansScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchText = TextEditingController();
  late TabController tabControllerStatus;
  late ValueNotifier<FilterValueNotifier> _filteringData;

  List<Map<String, dynamic>> _scheduleTodayList = [];
  List<Map<String, dynamic>> _trucksVansStatusList = [];
  List<String> customerList = [];
  LoadingStatus _isLoadingSchedule = LoadingStatus.idle;
  LoadingStatus _isLoadingTrucksVans = LoadingStatus.idle;
  bool _isOnRefresh = false;

  @override
  void initState() {
    super.initState();
    _filteringData = ValueNotifier(FilterValueNotifier.empty);

    tabControllerStatus =
        TabController(length: tabsStatus.length, vsync: this, initialIndex: 0);
    tabControllerStatus.addListener(handleTabChanging);
  }

  @override
  void dispose() {
    super.dispose();

    tabControllerStatus.dispose();
    tabControllerStatus.removeListener(handleTabChanging);
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
      }
    }
  }

  void handleTabChanging() {
    if (!tabControllerStatus.indexIsChanging &&
        _filteringData.value.customerCode != null) {
      generateData(tabControllerStatus.index);
    }
  }

  Future<DataState<TrucksVansEntity>> getScheduleToday() async {
    setState(() => _isLoadingSchedule = LoadingStatus.loading);
    final res = await getIt<GetScheduleTodayUseCase>().call(TrucksVansParams(
        customerCode: _filteringData.value.customerCode.toString()));

    if (res is DataSuccess) {
      setState(() {
        _scheduleTodayList = res.resp!.data!;
        _isLoadingSchedule = LoadingStatus.success;
      });
    } else {
      setState(() {
        _isLoadingSchedule = LoadingStatus.failed;
      });
    }
    return res;
  }

  Future<DataState<TrucksVansEntity>> getTrucksVansStatus() async {
    setState(() => _isLoadingTrucksVans = LoadingStatus.loading);
    final res = await getIt<GetTrucksVansStatusUseCase>().call(TrucksVansParams(
        customerCode: _filteringData.value.customerCode.toString()));

    if (res is DataSuccess) {
      setState(() {
        _trucksVansStatusList = res.resp!.data!;
        _isLoadingTrucksVans = LoadingStatus.success;
      });
    } else {
      setState(() {
        _isLoadingTrucksVans = LoadingStatus.failed;
      });
    }
    return res;
  }

  Future<DataState<TrucksVansStatusDetailsEntity>> getStatusDetails(
      String vanMonitorNo) async {
    return getIt<GetStatusDetailsUseCase>().call(TrucksVansStatusDetailsParams(
      customerCode: _filteringData.value.customerCode.toString(),
      action: 'view',
      vanMonitorNo: vanMonitorNo,
    ));
  }

  void onSelectCustomer(String customerCode) {
    _filteringData.value =
        _filteringData.value.copyWith(customerCode: customerCode);
  }

  void onClearData() {
    _filteringData.value = FilterValueNotifier.empty;

    setState(() {
      _scheduleTodayList = [];
      _trucksVansStatusList = [];
    });
  }

  Future<DataState<TrucksVansEntity>> generateData(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return getTrucksVansStatus();
      default:
        return getScheduleToday();
    }
  }

  void onFilterData() {
    if (_filteringData.value.customerCode != null) {
      // Close filtering modal
      Navigator.of(context).pop();

      generateData(tabControllerStatus.index);
    }
  }

  Future<void> onRefresh() async {
    if (_filteringData.value.customerCode != null) {
      setState(() => _isOnRefresh = true);
      await generateData(tabControllerStatus.index);
      setState(() => _isOnRefresh = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TrucksVansTemplate(
          customerList: customerList,
          scheduleList: _scheduleTodayList,
          trucksVansStatusList: _trucksVansStatusList,
          searchText: _searchText,
          filteringData: _filteringData,
          tabsStatus: tabsStatus,
          tabControllerStatus: tabControllerStatus,
          getStatusDetails: getStatusDetails,
          onRefresh: onRefresh,
          onSelectCustomer: onSelectCustomer,
          onFilterData: onFilterData,
          onClearData: onClearData,
        ),
        MDLoadingFullScreen(
          isLoading: (_isLoadingSchedule == LoadingStatus.loading ||
                  _isLoadingTrucksVans == LoadingStatus.loading) &&
              _isOnRefresh == false,
        )
      ],
    );
  }
}
