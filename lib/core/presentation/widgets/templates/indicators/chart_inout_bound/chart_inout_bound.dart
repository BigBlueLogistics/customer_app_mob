import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/screens/indicators/data/data.dart';
import 'chart_inout_bound_card.dart';

class ChartInoutBound extends StatelessWidget {
  const ChartInoutBound({
    super.key,
    required this.data,
  });

  final Iterable<ChartData> data;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ChartInOutBoundCard(
            title: data.elementAt(index).title.toString(),
            dates: data.elementAt(index).dates.toList(),
            values: data.elementAt(index).values.toList(),
          );
        });
  }
}
