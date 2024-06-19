import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/presentation/screens/trucks_vans/data/data.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/trucks_vans/tab_trucks_vans_status.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/trucks_vans/tab_schedule_today.dart';
import 'modal_filter_content.dart';

class TrucksVansTemplate extends StatelessWidget {
  const TrucksVansTemplate({
    super.key,
    required this.tabControllerStatus,
    required this.customerList,
    required this.scheduleList,
    required this.trucksVansStatusList,
    required this.tabsStatus,
    required this.searchText,
    required this.filteringData,
    required this.getStatusDetails,
    required this.onRefresh,
    required this.onSelectCustomer,
    required this.onFilterData,
    required this.onClearData,
  });

  final TabController tabControllerStatus;
  final List<String> customerList;
  final List<Map<String, dynamic>> scheduleList;
  final List<Map<String, dynamic>> trucksVansStatusList;
  final List<Tab> tabsStatus;
  final TextEditingController searchText;
  final ValueNotifier<FilterValueNotifier> filteringData;
  final Future<DataState<TrucksVansStatusDetailsEntity>> Function(
      String vanMonitorNo) getStatusDetails;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onSelectCustomer;
  final VoidCallback onFilterData;
  final VoidCallback onClearData;

  void showFiltering(BuildContext context) {
    showModalBottomSheet<void>(
        isDismissible: true,
        showDragHandle: true,
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        scrollControlDisabledMaxHeightRatio: 1,
        builder: (BuildContext context) {
          return ModalFilterContent(
            customerList: customerList,
            filteringData: filteringData,
            onFilterData: onFilterData,
            onSelectCustomer: onSelectCustomer,
            onClearFilter: onClearData,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Trucks & Vans',
      appBarBottom: TabBar(
        controller: tabControllerStatus,
        isScrollable: true,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.white54,
        indicatorColor: Colors.black87,
        tabs: tabsStatus.map((tab) => Tab(text: tab.text)).toList(),
      ),
      actions: [
        IconButton(
          onPressed: () => showFiltering(context),
          icon: const Icon(
            Icons.filter_alt_rounded,
            color: Colors.white,
          ),
        ),
      ],
      child: TabBarView(controller: tabControllerStatus, children: [
        TabScheduleToday(onRefresh: onRefresh, data: scheduleList),
        TabTrucksVansStatus(
            onRefresh: onRefresh,
            data: trucksVansStatusList,
            getStatusDetails: getStatusDetails)
      ]),
    );
  }
}
