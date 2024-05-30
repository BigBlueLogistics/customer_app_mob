import 'package:customer_app_mob/core/domain/entities/reports.dart';

class ReportsModel extends ReportsEntity {
  const ReportsModel({super.data, super.message, super.status});

  factory ReportsModel.fromJson(Map<String, dynamic> json) {
    return ReportsModel(
        data: List<Map<String, dynamic>>.from(json['data']).toList(),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = ReportsModel();
}
