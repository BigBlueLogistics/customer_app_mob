import 'package:equatable/equatable.dart';

class Inventory extends Equatable {
  const Inventory({this.status, this.data, this.message});

  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  @override
  List<Object?> get props => [status, data, message];
}
