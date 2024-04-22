import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({this.status, this.data, this.message});

  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  @override
  List<Object?> get props => [status, data, message];
}
