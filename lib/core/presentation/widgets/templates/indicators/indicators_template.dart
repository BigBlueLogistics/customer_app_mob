import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/indicators/statistics/statistics.dart';
import 'package:customer_app_mob/core/presentation/screens/indicators/data/data.dart';
import 'modal_filter_content.dart';

class IndicatorsTemplate extends StatelessWidget {
  const IndicatorsTemplate({
    super.key,
    required this.statisticsList,
    required this.customerList,
    required this.filteringData,
    required this.onSelectCustomer,
    required this.onFilterData,
    required this.onRefresh,
  });

  final List<String> customerList;
  final ValueNotifier<FilterValueNotifier> filteringData;
  final Iterable<StatisticsData> statisticsList;
  final ValueChanged<String> onSelectCustomer;
  final VoidCallback onFilterData;
  final Future<void> Function() onRefresh;

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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Indicators',
      actions: [
        IconButton(
          onPressed: () => showFiltering(context),
          icon: const Icon(
            Icons.filter_alt_rounded,
            color: Colors.white,
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: <Widget>[Statistics(data: statisticsList)],
          ),
        ),
      ),
    );
  }
}
