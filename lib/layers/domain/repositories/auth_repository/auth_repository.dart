import 'package:project_setup/core/network/error_response.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';
import 'package:project_setup/layers/data/models/base_response_model.dart';
import 'package:project_setup/layers/domain/repositories/base_api_repository.dart';

import '../../../data/models/auth_models/request_models/login_request.dart';

abstract class AuthRepository extends BaseApiRepository {
  Future<({BaseResponseModel<LoginResponseData?>? response, ErrorResponse? error})> login({
    required LoginRequest loginRequest,
  });
}
