import 'package:project_setup/core/network/error_response.dart';

mixin BaseApiUseCase<Response, Params> {
  Future<({Response? response, ErrorResponse? error})> call(Params params);
}

mixin BaseApiUseCaseWithoutParams<Response> {
  Future<({Response? response, ErrorResponse? error})> call();
}
