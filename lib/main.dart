import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_setup/app/project_app.dart';
import 'package:project_setup/core/utils/permission_helper.dart';

import 'core/constants/app_enums.dart';
import 'injector/injector.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// not integrate with firebase
      // await Firebase.initializeApp();
      await Injector.setUp();
      // await sl<FCMHelper>().setUpNotification();
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      if (!kReleaseMode) {
        dev.log(':::::::::::::::::::::::::::::::::::::::::::::::');
        dev.log(':: runZonedGuarded error :: ${error.toString()}');
        dev.log(':::::::::::::::::::::::::::::::::::::::::::::::');
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Request Permission Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// *********************> here as of now two permission are added for example (contact and location in podfile and infoPlist).
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  PermissionHelper(PermissionType.storage).onPermissionDenied(() {
                    // Handle permission denied for location
                    debugPrint('storage permission denied');
                  }).onPermissionGranted(() {
                    // Handle permission granted for location
                    debugPrint('storage permission granted');
                  }).onPermissionPermanentlyDenied(() {
                    debugPrint('storage permission permanently denied');
                  }).execute();
                },
                child: const Text("Request storage Permission")),
            ElevatedButton(
                onPressed: () {
                  PermissionHelper(PermissionType.readContacts).onPermissionDenied(() {
                    // Handle permission denied for location
                    debugPrint('Contacts permission denied');
                  }).onPermissionGranted(() {
                    // Handle permission granted for location
                    debugPrint('Contacts permission granted');
                  }).onPermissionPermanentlyDenied(() {
                    // Handle permission permanently denied for location
                    openAppSettings();
                    debugPrint('Contacts permission permanently denied');
                  }).execute();
                },
                child: const Text("Request contacts Permission")),
            ElevatedButton(
              onPressed: () {
                PermissionHelper(PermissionType.whenInUseLocation).onPermissionDenied(() {
                  // Handle permission denied for location
                  print('Location permission denied');
                }).onPermissionGranted(() {
                  // Handle permission granted for location
                  print('Location permission granted');
                }).onPermissionPermanentlyDenied(() {
                  // Handle permission permanently denied for location
                  print('Location permission permanently denied');
                }).execute();
              },
              child: const Text("Request location Permission"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
