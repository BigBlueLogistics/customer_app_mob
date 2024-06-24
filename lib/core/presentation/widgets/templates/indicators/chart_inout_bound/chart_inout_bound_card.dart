import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:customer_app_mob/config/constants/text.dart';
import 'package:customer_app_mob/config/theme/colors.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_chart_legend/md_chart_legend.dart';

class ChartInOutBoundCard extends StatelessWidget {
  const ChartInOutBoundCard(
      {super.key,
      required this.title,
      required this.dates,
      required this.values});

  final String title;
  final List<dynamic> dates;
  final List<dynamic> values;

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;

    text = dates.elementAt(value.toInt());

    return SideTitleWidget(
      fitInside: SideTitleFitInsideData(
          enabled: true,
          distanceFromEdge: -10,
          axisPosition: 0,
          parentAxisSize: 0),
      axisSide: meta.axisSide,
      angle: 200.0,
      child: Text(text, style: style),
    );
  }

  Widget horizontalSideTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  double parseToDouble(dynamic value) {
    var parsedValue = value;

    if (parsedValue.runtimeType == String) {
      parsedValue = double.tryParse(parsedValue) ?? 0.0;
    } else if (parsedValue.runtimeType == int) {
      parsedValue = 0.0 + parsedValue;
    }

    return parsedValue;
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    final inbound = values[0] as List<dynamic>;
    final outbound = values[1] as List<dynamic>;

    return inbound.asMap().entries.map((entry) {
      final idx = entry.key;
      final inboundValue = parseToDouble(entry.value);
      final outboundValue = parseToDouble(outbound[idx]);

      return BarChartGroupData(
        x: idx,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: inboundValue + outboundValue,
            rodStackItems: [
              BarChartRodStackItem(0, inboundValue, AppColors.info),
              BarChartRodStackItem(inboundValue, inboundValue + outboundValue,
                  AppColors.warning),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.text,
              ),
            ),
            Center(
              child: MDLegendsListWidget(legends: [
                Legend('Inbound', AppColors.info),
                Legend('Outbound', AppColors.warning),
              ]),
            ),
            ScrollableChart(),
          ],
        ),
      ),
    );
  }

  Widget ScrollableChart() {
    if (values.isEmpty) {
      return SizedBox(
        height: 200,
        width: double.infinity,
        child: Center(
            child: const Text(
          AppConstantText.noDataAvailable,
          style: TextStyle(color: AppColors.text, fontSize: 12),
        )),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 500,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barsSpace = 4.0 * constraints.maxWidth / 400;
              final barsWidth = 8.0 * constraints.maxWidth / 400;
              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: bottomTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: horizontalSideTitles,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: horizontalSideTitles,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 5 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    ),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  groupsSpace: barsSpace,
                  barGroups: getData(barsWidth, barsSpace),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
