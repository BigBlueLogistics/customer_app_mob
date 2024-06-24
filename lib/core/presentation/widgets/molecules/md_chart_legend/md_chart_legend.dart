import 'package:customer_app_mob/config/theme/colors.dart';
import 'package:flutter/material.dart';

class MDLegendsListWidget extends StatelessWidget {
  const MDLegendsListWidget({
    super.key,
    required this.legends,
  });
  final List<Legend> legends;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: legends
          .map(
            (e) => LegendChart(
              name: e.name,
              color: e.color,
            ),
          )
          .toList(),
    );
  }
}

class LegendChart extends StatelessWidget {
  const LegendChart({
    super.key,
    required this.name,
    required this.color,
  });
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class Legend {
  Legend(this.name, this.color);
  final String name;
  final Color color;
}
