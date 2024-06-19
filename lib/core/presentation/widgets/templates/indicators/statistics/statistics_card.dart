import 'package:flutter/material.dart';
import 'package:customer_app_mob/config/theme/colors.dart';

enum StatisticsIconBgColor { dark, blue, darkpink, orange }

class StatisticsCard extends StatelessWidget {
  const StatisticsCard(
      {super.key,
      required this.index,
      required this.title,
      required this.icon,
      required this.iconColor,
      required this.currentValue,
      required this.yesterdayValue});

  final int index;
  final String title;
  final String icon;
  final StatisticsIconBgColor iconColor;
  final String currentValue;
  final String yesterdayValue;

  List<Color> boxShadowColor(StatisticsIconBgColor color) {
    switch (color) {
      case StatisticsIconBgColor.blue:
        return [
          const Color.fromRGBO(0, 0, 0, 0.14),
          const Color.fromRGBO(0, 187, 212, 0.4),
        ];
      case StatisticsIconBgColor.orange:
        return [
          const Color.fromRGBO(0, 0, 0, 0.14),
          const Color.fromRGBO(255, 153, 0, 0.4),
        ];

      case StatisticsIconBgColor.dark:
        return [
          const Color.fromRGBO(0, 0, 0, 0.14),
          const Color.fromRGBO(64, 64, 64, 0.4),
        ];
      default:
        return [
          const Color.fromRGBO(0, 0, 0, 0.14),
          const Color.fromRGBO(233, 30, 98, 0.4),
        ];
    }
  }

  List<Color> boxBackgroundColor(StatisticsIconBgColor color) {
    switch (color) {
      case StatisticsIconBgColor.blue:
        return [
          const Color.fromRGBO(73, 163, 241, 1),
          const Color.fromRGBO(26, 115, 232, 1),
        ];
      case StatisticsIconBgColor.orange:
        return [
          const Color.fromRGBO(255, 167, 38, 1),
          const Color.fromRGBO(251, 140, 0, 1),
        ];

      case StatisticsIconBgColor.dark:
        return [
          const Color.fromRGBO(66, 66, 74, 1),
          const Color.fromRGBO(25, 25, 25, 1),
        ];
      default:
        return [
          const Color.fromRGBO(236, 64, 122, 1),
          const Color.fromRGBO(216, 27, 96, 1),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.only(bottom: 18.0),
      child: Card(
        elevation: 3,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Positioned(
              top: -15,
              left: 12,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: boxShadowColor(iconColor)[0],
                        offset: const Offset(0, 1),
                        blurRadius: 1.25),
                    BoxShadow(
                        color: boxShadowColor(iconColor)[1],
                        offset: const Offset(0, 1.5),
                        blurRadius: 0.66,
                        spreadRadius: 0.32)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                      colors: boxBackgroundColor(iconColor),
                      stops: const [0, 1],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(icon)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: AppColors.text, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    currentValue,
                    style: TextStyle(
                        color: AppColors.dark,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const Center(
                      child: Divider(
                    indent: 0,
                    thickness: 0.5,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Yesterday',
                        style: TextStyle(
                            color: AppColors.text, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        yesterdayValue,
                        style: TextStyle(
                            color: AppColors.dark, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
