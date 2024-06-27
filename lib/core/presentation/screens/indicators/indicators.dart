import 'dart:async';

import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/core/domain/repository/indicators_repository.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_loading/md_loading.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/core/usecases/indicators/get_active_sku.dart';
import 'package:customer_app_mob/core/usecases/indicators/get_inout_bound.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/indicators/indicators_template.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './data/data.dart';

class IndicatorsScreen extends StatefulWidget {
  const IndicatorsScreen({super.key});

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  late ValueNotifier<FilterValueNotifier> _filteringData;
  late List<String> customerList;

  late Iterable<StatisticsData> _statisticsList;
  late Iterable<ChartData> _chartList;
  LoadingStatus _isLoadingStatistics = LoadingStatus.idle;
  LoadingStatus _isLoadingCharts = LoadingStatus.idle;
  bool _isOnRefresh = false;

  @override
  void initState() {
    super.initState();
    _filteringData = ValueNotifier(FilterValueNotifier.empty);
    _statisticsList = statisticsList.values;
    _chartList = chartList.values;
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

  Future<void> generateData() async {
    setState(() {
      _isLoadingStatistics = LoadingStatus.loading;
      _isLoadingCharts = LoadingStatus.loading;
    });

    final [activeSkuData, inOutboundData] = await Future.wait([
      getIt<GetActiveSkuUseCase>().call(IndicatorsParams(
          customerCode: _filteringData.value.customerCode.toString())),
      getIt<GetInOutboundUseCase>().call(IndicatorsParams(
          customerCode: _filteringData.value.customerCode.toString()))
    ]);

    if (activeSkuData is DataSuccess) {
      final resp = activeSkuData.resp!.data!;

      setState(() {
        _statisticsList = updateStatisticsData(resp);
        _isLoadingStatistics = LoadingStatus.success;
      });
    } else {
      setState(() => _isLoadingStatistics = LoadingStatus.failed);
    }

    if (inOutboundData is DataSuccess) {
      final resp = inOutboundData.resp!.data!;

      setState(() {
        _chartList = updateChartData(resp);
        _isLoadingCharts = LoadingStatus.success;
      });
    } else {
      setState(() => _isLoadingCharts = LoadingStatus.failed);
    }
  }

  Iterable<StatisticsData> updateStatisticsData(Map<String, dynamic> data) {
    final today = data['today'];
    final yesterday = data['yesterday'];
    statisticsList.update(
      'outbound',
      (value) => value.copyWith(
          todayValue: today['outboundSum'].toString(),
          yesterdayValue: yesterday['outboundSum'].toString()),
    );
    statisticsList.update(
      'inbound',
      (value) => value.copyWith(
          todayValue: today['inboundSum'].toString(),
          yesterdayValue: yesterday['inboundSum'].toString()),
    );
    statisticsList.update(
      'transaction',
      (value) => value.copyWith(
          todayValue: today['transactionCount'].toString(),
          yesterdayValue: yesterday['transactionCount'].toString()),
    );
    statisticsList.update(
      'activeSku',
      (value) => value.copyWith(
          todayValue: today['activeSku'].toString(),
          yesterdayValue: yesterday['activeSku'].toString()),
    );

    return statisticsList.values;
  }

  Iterable<ChartData> updateChartData(Map<String, dynamic> data) {
    final byWeight = data['byWeight'];
    final byTransactions = data['byTransactions'];
    chartList.update(
      'inbound',
      (value) =>
          value.copyWith(dates: byWeight['dates'], values: byWeight['weight']),
    );
    chartList.update(
      'outbound',
      (value) => value.copyWith(
          dates: byTransactions['dates'], values: byTransactions['counts']),
    );

    return chartList.values;
  }

  Future<void> onRefresh() async {
    if (_filteringData.value.customerCode != null) {
      setState(() => _isOnRefresh = true);
      await generateData();
      setState(() => _isOnRefresh = false);
    }
  }

  void onSelectCustomer(String customerCode) {
    _filteringData.value =
        _filteringData.value.copyWith(customerCode: customerCode);
  }

  void onFilterData() {
    if (_filteringData.value.customerCode != null) {
      // Close filtering modal
      Navigator.of(context).pop();

      generateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IndicatorsTemplate(
          statisticsList: _statisticsList,
          chartList: _chartList,
          filteringData: _filteringData,
          customerList: customerList,
          onRefresh: onRefresh,
          onSelectCustomer: onSelectCustomer,
          onFilterData: onFilterData,
        ),
        MDLoadingFullScreen(
          isLoading: (_isLoadingStatistics == LoadingStatus.loading ||
                  _isLoadingCharts == LoadingStatus.loading) &&
              _isOnRefresh == false,
        )
      ],
    );
  }
}
