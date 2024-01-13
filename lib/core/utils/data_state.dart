import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? resp;
  final DioException? error;

  const DataState({this.resp, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T resp) : super(resp: resp);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
