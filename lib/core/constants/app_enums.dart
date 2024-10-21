enum HiveEntityKeys {
  ///logged in user data
  loggedInUser("loggedInUserData"),

  /// fcm token
  fcmToken("fcmToken");

  final String value;
  const HiveEntityKeys(this.value);
}
