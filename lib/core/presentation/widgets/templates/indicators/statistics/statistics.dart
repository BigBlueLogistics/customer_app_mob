import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/screens/indicators/data/data.dart';
import 'statistics_card.dart';

class Statistics extends StatelessWidget {
  const Statistics({
    super.key,
    required this.data,
  });

  final Iterable<StatisticsData> data;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return StatisticsCard(
            index: index,
            title: data.elementAt(index).title.toString(),
            currentValue: data.elementAt(index).todayValue.toString(),
            yesterdayValue: data.elementAt(index).yesterdayValue.toString(),
            icon: data.elementAt(index).icon.toString(),
            iconColor:
                data.elementAt(index).iconColor as StatisticsIconBgColor);
      },
    );
  }
}
