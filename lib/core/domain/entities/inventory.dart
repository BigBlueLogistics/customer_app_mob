import 'package:equatable/equatable.dart';

class InventoryEntity extends Equatable {
  const InventoryEntity({this.status, this.data, this.message});

  final String? status;
  final String? message;
  final List<Map<String, dynamic>>? data;

  @override
  List<Object?> get props => [status, data, message];
}
