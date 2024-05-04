import 'package:customer_app_mob/core/domain/entities/warehouse.dart';

class WarehouseModel extends WarehouseEntity {
  const WarehouseModel({super.data, super.message, super.status});

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
        data: List<Map<String, dynamic>>.from(json['data']).toList(),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = WarehouseModel();
}
