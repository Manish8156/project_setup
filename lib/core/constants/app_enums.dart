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
