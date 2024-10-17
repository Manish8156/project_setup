import 'package:dio/dio.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';
import 'package:project_setup/layers/data/models/base_response_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:project_setup/core/network/apis.dart';

import '../../layers/data/models/auth_models/request_models/login_request.dart';

part 'retrofit_api_client.g.dart';

@RestApi()
abstract class RetrofitApiClient {
  factory RetrofitApiClient({required Dio dio}) {
    return RetrofitApiClient(dio: dio);
  }

  @POST(Apis.login)
  Future<HttpResponse<BaseResponseModel<LoginResponseData?>?>> login(
    @Body() LoginRequest loginRequest,
  );
}
