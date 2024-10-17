import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_setup/layers/flavor_config.dart';
import 'package:retry/retry.dart';
import '../../injector/injector.dart';
import '../constants/app_constants.dart';
import '../globals.dart';
import 'api_status_code.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(baseUrl: FlavorsConfig.instance!.baseUrl));

  static Dio getInstance() {
    AuthInterceptor authInterceptor = sl<AuthInterceptor>();
    _dio.interceptors.add(authInterceptor);
    if (kDebugMode) {
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        logPrint: (object) => dev.log('$object'),
      );
    }
    return _dio;
  }
}

class AuthInterceptor extends Interceptor {
  /// bearer token is not pass in url which is available noAuthUrl list.
  /// contain url which is not contain token.
  static List<String> noAuthUrl = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (FlavorsConfig.instance!.environment == FlavorEnvironment.development) {
      await Future.delayed(const Duration(seconds: 3));
    }

    /// if backend side required the device id , the set to this deviceId in header.
    String? deviceId = await getDeviceId();

    /// currently in header only two values are defined.
    final header = {
      AppConstants.contentType: AppConstants.applicationJson,
      AppConstants.accept: AppConstants.applicationJson,
    };

    if (!noAuthUrl.contains(options.path)) {
      dev.log('onRequest loggedInUserToken :: { print the loggedInUserToken }');

      /// instead of [true] value , we have to check the [loggedInUserToken] is not null or empty
      if (true) {
        /// here in the value of loggedInUserToken we have to put the logged user token.
        header.putIfAbsent(AppConstants.authorization, () => '${AppConstants.bearer} loggedInUserToken');
      }
    }

    options.headers = header;
    options.connectTimeout = const Duration(seconds: 20);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    dev.log('onError loggedInUser Token : print the loggedInUserToken');

    /// below code for error... handling
    /// loggedInUserToken we have to set , which get value from the local
    // if ((loggedInUserToken.isNotNullOrEmpty) &&
    //     ((err.response?.statusCode == ApiStatusCode.status401) ||
    //         (err.response?.statusCode == ApiStatusCode.status498))) {
    //   doLogOut(
    //     context: AppConstants.navigatorContext,
    //   );
    // }

    if (err.response?.statusCode == ApiStatusCode.status500) {
      try {
        // return await _retry(err.requestOptions, handler);
        Response<dynamic> response = await _retryRequest(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        dev.log('onError retryRequest status500 : ${e.toString()}');
      }
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.headers.forEach((k, v) => dev.log('$k: $v'));
    super.onResponse(response, handler);
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions, {
    int maxAttempts = 3,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 2500));

      RetryOptions retryOptions = RetryOptions(
        maxAttempts: maxAttempts,
        delayFactor: const Duration(milliseconds: 2500),
      );

      Dio dio = Dio(BaseOptions(baseUrl: FlavorsConfig.instance!.baseUrl));

      if (kDebugMode) {
        dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      }

      return await retryOptions.retry(
        () async {
          return await dio.request<dynamic>(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
            ),
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
