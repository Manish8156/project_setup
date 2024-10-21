import 'dart:async';
import 'dart:developer' as dev;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_setup/layers/data/models/notification_model/notification_payload.dart';

import '../constants/app_constants.dart';
import 'app_common_imports.dart';

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage? message) async {
  dev.log('::==>> FCM _onBackgroundMessage method called - payload - ${message?.data}');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  if (message != null) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      await _onMessageOpened(message);
    });
  }
}

class FCMHelper {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setUpNotification() async {
    NotificationSettings settings = await requestPermissionFirebaseMessaging();
    try {
      if ((settings.authorizationStatus == AuthorizationStatus.authorized) ||
          (settings.authorizationStatus == AuthorizationStatus.provisional)) {
        /// when app is closed and the user received the notification(via fcm),the user tap on notification and the app is launched,
        /// hence getInitialMessage() retrieves the notification data that caused the app to open.
        FirebaseMessaging.instance.getInitialMessage().then(
          (value) async {
            if (value != null) {
              await Future.delayed(const Duration(seconds: 1));
              _onMessageOpened(value);
            }
          },
        );

        ///  onMessage is a listener, to handle foreground notifications
        FirebaseMessaging.onMessage.listen(_onMessage);

        /// onBackgroundMessage handler is used when the app is in the background (i.e., not visible to the user but still running) or terminated (i.e., not running at all)
        FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

        /// onMessageOpenedApp listener that is triggered when the app is opened via a notification tap while the app is in the background or terminated state.
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          _onMessageOpened(message);
        });

        cancelAllNotifications();
      }
    } on Exception catch (e) {
      dev.log('::==>> FCM setupNotification exception :: $e');
    }
  }

  Future<NotificationSettings> requestPermissionFirebaseMessaging() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    dev.log('::==>> FCM permission authorizationStatus :: ${settings.authorizationStatus}');

    return settings;
  }

  FutureOr<String> getFcmToken() async {
    dev.log('::==>> inside FCM Device Token :: ');
    try {
      String token = await firebaseMessaging.getToken() ?? '';
      dev.log('::==>> FCM Device Token :: $token');
      return token;
    } on FirebaseException catch (e) {
      dev.log('::==>> error FCM Device Token :: $e');
      return '';
    }
  }

  void _onMessage(RemoteMessage message) {
    //     dev.log('::==>> FCM _onMessage method called - payload - ${message.data}');
  }

  Future<void> cancelAllNotifications() async => await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> _onMessageOpened(RemoteMessage message) async {
  dev.log('::==>> FCM _onMessageOpened method called - payload - ${message.data}');
  await Future.delayed(const Duration(seconds: 1));

  /// NotificationPayload is model class , and message.data is dynamic getting.
  NotificationPayload notificationPayload = NotificationPayload.fromJson(message.data);

  /// below the code , show that , notificationPayload.type check where we have navigate , after launching our app
  /// according to our backend data , and response , we have to handle them,(below the commented code is a one type of example).
  /*
    if (notificationPayload.type.isNotNullOrEmpty) {
      if (notificationPayload.type == NotificationType.profileVisitor.value) {
        AppConstants.navigatorKey.currentState?.pushNamed(
          Routes.profilePage,
          arguments: {
            AppConstants.isOwnProfile: false,
            AppConstants.isGetProfileDetails: true,
            AppConstants.profileDetails: LoginData(
              id: notificationPayload.id ?? '',
            ),
          },
        );
      } else {
        AppConstants.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Routes.dashboardPage,
              (route) => false,
        );
      }
    } else {
      dev.log('::==>> FCM _onMessageOpened method called - notificationPayload type isNullOrEmpty');

      AppConstants.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        Routes.dashboardPage,
            (route) => false,
      );
    }
    */
}
