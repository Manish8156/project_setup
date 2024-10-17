import 'package:flutter/material.dart';

abstract class AppConstants {
  /// Keys
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static BuildContext get navigatorContext => navigatorKey.currentState!.context;

  /// Constant key identifiers
  static const String applicationJson = "application/json";
  static const String contentType = "content-type";
  static const String accept = "accept";
  static const String authorization = "Authorization";
  static const String bearer = "Bearer";
  static const String message = "message";
}
