import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/screens/trucks_vans/data/data.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/trucks_vans/modal_filter_content.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:intl/intl.dart';

class TrucksVansTemplate extends StatelessWidget {
  const TrucksVansTemplate({
    super.key,
    required this.currentTabIndex,
    required this.customerList,
    required this.scheduleList,
    required this.searchText,
    required this.onRefresh,
    required this.filteringData,
    required this.onSelectCustomer,
    required this.onTapCurrentTab,
    required this.onFilterData,
    required this.onClearData,
  });

  final int currentTabIndex;
  final List<String> customerList;
  final List<Map<String, dynamic>> scheduleList;
  final TextEditingController searchText;
  final Future<void> Function() onRefresh;
  final ValueNotifier<FilterValueNotifier> filteringData;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<int> onTapCurrentTab;
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
    const List<Tab> tabs = [
      Tab(text: 'Schedule Today'),
      Tab(text: 'Trucks and Vans Status'),
    ];

    return DefaultTabController(
      initialIndex: currentTabIndex,
      length: tabs.length,
      child: MDScaffold(
        appBarTitle: 'Trucks & Vans',
        appBarBottom: TabBar(
          onTap: onTapCurrentTab,
          isScrollable: true,
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.white54,
          indicatorColor: Colors.black87,
          tabs: tabs.map((tab) => Tab(text: tab.text)).toList(),
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
        child: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: scheduleList.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      itemCount: scheduleList.length,
                      itemBuilder: (context, index) {
                        final scheduleData = scheduleList[index];
                        DateTime formattedDate = DateTime.parse(
                            '${scheduleData['arrivaldate']} ${scheduleData['arrivaltime']}');
                        String formattedDateString =
                            DateFormat.yMMMd().add_jm().format(formattedDate);

                        return Card(
                          key: ValueKey(index.toString()),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0.3)),
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(5, 5))),
                          child: ListTile(
                            title: Text(scheduleList[index]['vehiclenum'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Type: ',
                                    ),
                                    Text(
                                      scheduleList[index]['vehicletype'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Arrival: ',
                                    ),
                                    Text(
                                      formattedDateString,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('No data available.')),
            ),
          ),
          const Text(
            'Trucks and Vans Status content',
            style: TextStyle(fontSize: 30),
          )
        ]),
      ),
    );
  }
}
