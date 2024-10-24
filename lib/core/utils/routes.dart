import 'package:flutter/material.dart';

import '../../layers/presentation/pages/splash_page.dart';
import 'not_found_page.dart';

abstract class Routes {
  static String initialRoute = splashPage;

  /// initial routes
  static const String splashPage = '/';
  static const String startPage = 'startPage';

  /// define routes of the app...
  static Route<dynamic> appRoutes(RouteSettings settings) {
    switch (settings.name) {
      /// initial page
      case Routes.splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }
  }
}
