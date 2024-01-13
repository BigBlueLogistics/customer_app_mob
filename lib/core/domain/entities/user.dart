import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? status;
  final Map<String, dynamic>? data;
  final String? message;

  const UserEntity({this.status, this.data, this.message});

  @override
  List<Object?> get props => [status, data, message];
}
