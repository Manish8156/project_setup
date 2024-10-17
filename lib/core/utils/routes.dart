import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'not_found_page.dart';

abstract class Routes {
  static String initialRoute = splashPage;

  /// auth flow
  static const String splashPage = '/';
  static const String startPage = 'startPage';

  /// define routes of the app...
  static Route<dynamic> appRoutes(RouteSettings settings) {
    switch (settings.name) {
      /// initial page
      // case Routes.splashPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const SplashPage(),
      //     settings: settings,
      //   );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }
  }
}
