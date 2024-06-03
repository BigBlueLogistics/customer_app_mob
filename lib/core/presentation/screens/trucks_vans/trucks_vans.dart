import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/core/domain/repository/trucks_vans_repository.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/trucks_vans/data/data.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_schedule_today.dart';
import 'package:customer_app_mob/core/usecases/trucks_vans/get_trucks_vans_status.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/trucks_vans/trucks_vans_template.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrucksVansScreen extends StatefulWidget {
  const TrucksVansScreen({super.key});

  @override
  State<TrucksVansScreen> createState() => _TrucksVansScreenState();
}

class _TrucksVansScreenState extends State<TrucksVansScreen> {
  final TextEditingController _searchText = TextEditingController();
  final ValueNotifier<FilterValueNotifier> _filteringData =
      ValueNotifier(FilterValueNotifier.empty);

  List<Map<String, dynamic>> _scheduleTodayList = [];
  List<Map<String, dynamic>> _trucksVansStatusList = [];
  LoadingStatus _isLoadingSchedule = LoadingStatus.idle;
  LoadingStatus _isLoadingTrucksVans = LoadingStatus.idle;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void getScheduleToday() async {
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
  }

  void getTrucksVansStatus() async {
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

  void onFilterData() {
    // Close filtering modal
    if (_filteringData.value.customerCode != null) {
      Navigator.of(context).pop();

      if (_currentTabIndex == 0) {
        getScheduleToday();
      }
      if (_currentTabIndex == 1) {
        getTrucksVansStatus();
      }
    }
  }

  void onTapCurrentTab(int tabIndex) {
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  Future<void> onRefresh() async {
    onFilterData();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final customerList =
        List<String>.from(authState.user.data!['user']['companies']).toList();

    return Stack(
      children: [
        TrucksVansTemplate(
          customerList: customerList,
          scheduleList: _scheduleTodayList,
          searchText: _searchText,
          filteringData: _filteringData,
          currentTabIndex: _currentTabIndex,
          onTapCurrentTab: onTapCurrentTab,
          onRefresh: onRefresh,
          onSelectCustomer: onSelectCustomer,
          onFilterData: onFilterData,
          onClearData: onClearData,
        ),
        MDLoadingFullScreen(
          isLoading: _isLoadingSchedule == LoadingStatus.loading ||
              _isLoadingTrucksVans == LoadingStatus.loading,
        )
      ],
    );
  }
}
