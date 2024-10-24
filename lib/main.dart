import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_setup/app/project_app.dart';

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
      runApp(const ProjectApp());
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
