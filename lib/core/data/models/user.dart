import 'package:customer_app_mob/core/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({super.message, super.data, super.status});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        status: json['status'], data: json['data'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data, 'status': status};
  }

  static const empty = UserModel();
}
