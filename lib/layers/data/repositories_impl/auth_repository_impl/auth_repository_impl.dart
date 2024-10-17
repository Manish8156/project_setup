import 'package:project_setup/core/network/api_status_code.dart';
import 'package:project_setup/core/network/error_response.dart';
import 'package:project_setup/core/network/response_wrapper.dart';
import 'package:project_setup/core/network/retrofit_api_client.dart';
import 'package:project_setup/layers/data/models/auth_models/request_models/login_request.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';
import 'package:project_setup/layers/data/models/base_response_model.dart';
import 'package:project_setup/layers/domain/repositories/auth_repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  RetrofitApiClient retrofitApiClient;

  AuthRepositoryImpl({
    required this.retrofitApiClient,
  });

  @override
  Future<({BaseResponseModel<LoginResponseData?>? response, ErrorResponse? error})> login(
      {required LoginRequest loginRequest}) async {
    try {
      ResponseWrapper<BaseResponseModel<LoginResponseData?>?> retrofitResponse = await handleHttpReqRes(
        httpRequest: () => retrofitApiClient.login(loginRequest),
      );

      if (retrofitResponse.hasError) {
        return (response: null, error: retrofitResponse.getError);
      } else if (retrofitResponse.hasData) {
        return (response: retrofitResponse.getData, error: null);
      } else {
        return (response: null, error: null);
      }
    } catch (e) {
      return (response: null, error: ErrorResponse(code: ApiStatusCode.statusMinus1, message: e.toString()));
    }
  }
}
