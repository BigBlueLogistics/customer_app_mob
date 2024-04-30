import 'package:customer_app_mob/core/domain/entities/inventory.dart';

class InventoryModel extends InventoryEntity {
  const InventoryModel({super.data, super.message, super.status});

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
        data: List<Map<String, dynamic>>.from(json['data']).toList(),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = InventoryModel();
}
