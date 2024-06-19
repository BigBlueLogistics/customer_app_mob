import 'package:customer_app_mob/core/domain/entities/indicators.dart';

class IndicatorsStatisticsModel extends IndicatorsStatisticsEntity {
  const IndicatorsStatisticsModel({super.data, super.message, super.status});

  factory IndicatorsStatisticsModel.fromJson(Map<String, dynamic> json) {
    return IndicatorsStatisticsModel(
        data: json['data'], message: json['message'], status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = IndicatorsStatisticsModel();
}

class IndicatorsChartsModel extends IndicatorsChartsEntity {
  const IndicatorsChartsModel({super.data, super.message, super.status});

  factory IndicatorsChartsModel.fromJson(Map<String, dynamic> json) {
    return IndicatorsChartsModel(
        data: json['data'], message: json['message'], status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = IndicatorsChartsModel();
}
