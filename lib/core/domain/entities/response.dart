import 'package:equatable/equatable.dart';

typedef TResponseData = Map<String, dynamic>;

class ResponseEntity<TData> extends Equatable {
  const ResponseEntity({this.data, this.message, this.status});

  final String? status;
  final String? message;
  final TData? data;

  @override
  List<Object?> get props => [message, status, data];
}
