import 'package:project_setup/core/network/error_response.dart';

class ResponseWrapper<T> {
  T? _data;
  ErrorResponse? _error;

  void setData(T? data) {
    _data = data;
  }

  void setError(ErrorResponse error) {
    _error = error;
  }

  T get getData => _data!;

  ErrorResponse get getError => _error!;

  bool get hasData => _data != null;

  bool get hasError => _error != null;
}
