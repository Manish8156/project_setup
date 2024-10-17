import 'package:dio/dio.dart';
import 'package:project_setup/core/network/api_status_code.dart';
import 'package:project_setup/core/network/error_response.dart';
import 'package:project_setup/core/network/network_info.dart';
import 'package:project_setup/core/network/server_error.dart';
import 'package:retrofit/retrofit.dart';
import 'package:project_setup/core/network/response_wrapper.dart';
import '../../../core/utils/app_common_imports.dart';

abstract class BaseApiRepository {
  Future<ResponseWrapper<T>> handleHttpReqRes<T>({
    required Future<HttpResponse<T>> Function() httpRequest,
  }) async {
    ResponseWrapper<T> responseWrapper = ResponseWrapper<T>();
    NetworkInfo networkInfo = sl<NetworkInfo>();
    try {
      if (await networkInfo.isConnected) {
        HttpResponse<T> httpResponse = await httpRequest();
        if (httpResponse.response.statusCode == ApiStatusCode.status200) {
          responseWrapper.setData(httpResponse.data);
        } else {
          throw DioException(
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          );
        }
      } else {
        responseWrapper.setError(
          ErrorResponse(
            code: ApiStatusCode.statusMinus200,
            message: AppConstants.navigatorContext.localization?.noInternetConnection ?? '',
          ),
        );
      }
    } on DioException catch (error) {
      responseWrapper
          .setError(ErrorResponse(code: error.response?.statusCode, message: await ServerError.handleError(error)));
    } on Exception catch (e) {
      responseWrapper.setError(ErrorResponse(code: ApiStatusCode.statusMinus1, message: e.toString()));
    }
    return responseWrapper;
  }
}
