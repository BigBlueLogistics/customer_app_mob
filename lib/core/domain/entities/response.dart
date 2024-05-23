import 'package:equatable/equatable.dart';

class ResponseEntity extends Equatable {
  const ResponseEntity({this.data, this.message, this.status});

  final String? status;
  final String? message;
  final List<Map<String, dynamic>>? data;

  @override
  List<Object?> get props => [message, status, data];
}
