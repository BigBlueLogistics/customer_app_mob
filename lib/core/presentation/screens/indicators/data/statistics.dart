import 'package:customer_app_mob/config/constants/images.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/indicators/statistics/statistics_card.dart';

class StatisticsData {
  const StatisticsData(
      {this.title,
      this.icon,
      this.iconColor,
      this.todayValue,
      this.yesterdayValue});

  final String? title;
  final String? icon;
  final StatisticsIconBgColor? iconColor;
  final String? todayValue;
  final String? yesterdayValue;

  StatisticsData copyWith(
      {String? title,
      String? icon,
      StatisticsIconBgColor? iconColor,
      String? todayValue,
      String? yesterdayValue}) {
    return StatisticsData(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        iconColor: iconColor ?? this.iconColor,
        todayValue: todayValue ?? this.todayValue,
        yesterdayValue: yesterdayValue ?? this.yesterdayValue);
  }
}

final Map<String, StatisticsData> statisticsList = {
  'inbound': StatisticsData(
      title: 'Inbound Weight (kg)',
      icon: AppConstantImages.inboundIcon,
      iconColor: StatisticsIconBgColor.blue,
      todayValue: '0',
      yesterdayValue: '0'),
  'outbound': StatisticsData(
      title: 'Outbound Weight (kg)',
      icon: AppConstantImages.outboundIcon,
      iconColor: StatisticsIconBgColor.orange,
      todayValue: '0',
      yesterdayValue: '0'),
  'transaction': StatisticsData(
      title: 'Total Transaction',
      icon: AppConstantImages.totalTxnIcon,
      iconColor: StatisticsIconBgColor.dark,
      todayValue: '0',
      yesterdayValue: '0'),
  'activeSku': StatisticsData(
      title: 'Active SKU',
      icon: AppConstantImages.activeSkuIcon,
      iconColor: StatisticsIconBgColor.darkpink,
      todayValue: '0',
      yesterdayValue: '0'),
};
