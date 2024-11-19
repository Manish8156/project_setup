import 'package:project_setup/core/extensions/string_extension.dart';

enum AppEnvironment {
  development('development'),
  staging('staging'),
  production('production');

  final String value;
  const AppEnvironment(this.value);

  static AppEnvironment? fromValue(String? value) {
    if (value.isNotNullOrEmpty) {
      for (var environment in AppEnvironment.values) {
        if (value == environment.value) {
          return environment;
        }
      }
    }
    return null;
  }
}

enum HiveEntityKeys {
  /// logged in user token
  loggedInUserToken("loggedInUserToken"),

  ///logged in user data
  loggedInUser("loggedInUserData"),

  /// fcm token
  fcmToken("fcmToken");

  final String value;
  const HiveEntityKeys(this.value);
}

enum PermissionType {
  // Microphone
  recordAudio,

  // Camera
  camera,

  // Read External Storage (Android)
  storage,

  // Write External Storage (Android)
  manageExternalStorage,

  // receive notifications
  notification,

  location,

  // Access Coarse Location (Android) / When In Use iOS
  accessCoarseLocation,

  // Access Fine Location (Android) / When In Use iOS
  accessFineLocation,

  // Access Fine Location (Android) / When In Use iOS
  whenInUseLocation,

  // Access Fine Location (Android) / Always Location iOS
  alwaysLocation,

  // Write contacts (Android) / Contacts iOS
  writeContacts,

  // Read contacts (Android) / Contacts iOS
  readContacts,

  photos,
}
