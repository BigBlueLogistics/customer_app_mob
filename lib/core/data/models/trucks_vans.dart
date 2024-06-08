import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';

class TrucksVansModel extends TrucksVansEntity {
  const TrucksVansModel({super.data, super.message, super.status});

  factory TrucksVansModel.fromJson(Map<String, dynamic> json) {
    return TrucksVansModel(
        data: List<Map<String, dynamic>>.from(json['data']).toList(),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = TrucksVansModel();
}

class TrucksVansStatusDetailsModel extends TrucksVansStatusDetailsEntity {
  const TrucksVansStatusDetailsModel({super.data, super.message, super.status});

  factory TrucksVansStatusDetailsModel.fromJson(Map<String, dynamic> json) {
    return TrucksVansStatusDetailsModel(
        data: json['data'], message: json['message'], status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'message': message, 'status': status};
  }

  static const empty = TrucksVansStatusDetailsModel();
}
