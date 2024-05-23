import 'package:customer_app_mob/core/domain/entities/movement.dart';

class MovementModel extends MovementEntity {
  const MovementModel({super.data, super.message, super.status});

  factory MovementModel.fromJson(Map<String, dynamic> json) {
    return MovementModel(
        data: List<Map<String, dynamic>>.from(json['data']).toList(),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = MovementModel();
}

class MovementMaterialModel extends MovementMaterialEntity {
  const MovementMaterialModel({super.data, super.message, super.status});

  factory MovementMaterialModel.fromJson(Map<String, dynamic> json) {
    return MovementMaterialModel(
        data: List<Map<String, dynamic>>.from(json['data']).toList(),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = MovementMaterialModel();
}
