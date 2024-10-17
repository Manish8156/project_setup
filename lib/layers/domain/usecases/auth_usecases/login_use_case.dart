import 'package:project_setup/core/network/error_response.dart';
import 'package:project_setup/layers/data/models/auth_models/request_models/login_request.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';
import 'package:project_setup/layers/data/models/base_response_model.dart';
import 'package:project_setup/layers/domain/repositories/auth_repository/auth_repository.dart';
import 'package:project_setup/layers/domain/usecases/base_api_usecase.dart';

class LoginUseCase with BaseApiUseCase<BaseResponseModel<LoginResponseData?>?, LoginRequest> {
  final AuthRepository authRepository;

  LoginUseCase({
    required this.authRepository,
  });

  @override
  Future<({BaseResponseModel<LoginResponseData?>? response, ErrorResponse? error})> call(LoginRequest params) async {
    return await authRepository.login(loginRequest: params);
  }
}
