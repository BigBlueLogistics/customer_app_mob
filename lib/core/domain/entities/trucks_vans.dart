import 'package:equatable/equatable.dart';
import 'package:customer_app_mob/core/domain/entities/response.dart';

class TrucksVansEntity extends ResponseEntity {
  const TrucksVansEntity({super.data, super.message, super.status});
}

class TrucksVansStatusDetailsEntity extends Equatable {
  const TrucksVansStatusDetailsEntity({this.data, this.message, this.status});

  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  @override
  List<Object?> get props => [message, status, data];
}
