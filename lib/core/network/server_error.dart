import 'package:dio/dio.dart';
import 'package:project_setup/core/network/api_status_code.dart';

import '../utils/app_common_imports.dart';

abstract class ServerError {
  static Future<String> handleError(DioException error) async {
    String errorMessage = AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
    switch (error.type) {
      case DioExceptionType.cancel:
        errorMessage = AppConstants.navigatorContext.localization?.connectionTimeout ?? '';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = AppConstants.navigatorContext.localization?.connectionTimeout ?? '';
        break;
      case DioExceptionType.unknown:
        errorMessage = AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
        if (error.response != null) {
          errorMessage =
              error.response?.statusMessage ?? (AppConstants.navigatorContext.localization?.somethingWentWrong ?? '');
        }
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = AppConstants.navigatorContext.localization?.connectionTimeout ?? '';
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
          var msg = _handleServerError(error.response!);
          if (msg.isEmpty) {
            msg = error.toString();
          }
          errorMessage = msg;
        }
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = AppConstants.navigatorContext.localization?.connectionTimeout ?? '';
        break;
      default:
        errorMessage = error.message ?? '';
    }
    if (errorMessage.isEmpty) {
      errorMessage = AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
    }
    return errorMessage;
  }

  static String _handleServerError(Response? response) {
    if (response == null) {
      return AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
    }
    if (response.statusCode == ApiStatusCode.status400) {
      if (response.data != null) {
        return response.data?[AppConstants.message].toString() ??
            AppConstants.navigatorContext.localization?.somethingWentWrong ??
            '';
      } else {
        return response.statusMessage ?? AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
      }
    }

    if (response.statusCode == ApiStatusCode.status401) {
      if (response.data != null) {
        return response.data?[AppConstants.message].toString() ??
            AppConstants.navigatorContext.localization?.somethingWentWrong ??
            '';
      } else {
        return response.statusMessage ?? AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
      }
    }
    if (response.statusCode == ApiStatusCode.status404) {
      return AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
    }
    if (response.runtimeType == String) {
      return response.toString();
    }
    if (response.data != null && response.data.runtimeType == String) {
      return response.toString();
    }
    if (response.data != null) {
      return response.data?[AppConstants.message]?.toString() ??
          (AppConstants.navigatorContext.localization?.somethingWentWrong ?? '');
    }
    if (response.statusMessage != null && response.statusMessage!.isNotEmpty) {
      return response.statusMessage!;
    }
    return AppConstants.navigatorContext.localization?.somethingWentWrong ?? '';
  }
}
