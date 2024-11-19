import 'package:project_setup/core/constants/app_enums.dart';

/// note :: other files for env(prod, stag, dev) are mentioned in the gitIgnore,but current commented to understand concept of env
abstract class EnvConfig {
  static AppEnvironment? environment = AppEnvironment.fromValue(
    const String.fromEnvironment(
      'APP_ENVIRONMENT',
      defaultValue: 'development',
    ),
  );

  static const String baseUrl = String.fromEnvironment('BASE_URL');
}
