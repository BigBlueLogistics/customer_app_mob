import 'package:equatable/equatable.dart';

class WarehouseEntity extends Equatable {
  const WarehouseEntity({this.data, this.message, this.status});

  final String? status;
  final String? message;
  final List<Map<String, dynamic>>? data;

  @override
  List<Object?> get props => [message, status, data];
}
