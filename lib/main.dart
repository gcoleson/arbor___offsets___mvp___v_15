/*
*  main.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Greg
*  Copyright © 2020 412 Technology. All rights reserved.
    */
// @dart=2.9

import 'package:arbor___offsets___mvp___v_15/onboarding_screens/onboard_main_screen.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/projects_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/services/push_notifications.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const appVersion = String.fromEnvironment('APP_VERSION', defaultValue: '.1');
const appDate = String.fromEnvironment('APP_DATE', defaultValue: 'none');
FirebaseAnalytics analytics;

PackageInfo packageInfo;

void main() async {
  print("App Starting");

  //Boiler plate code ot get firebase initialized
  WidgetsFlutterBinding.ensureInitialized();

  packageInfo = await PackageInfo.fromPlatform();

  await Firebase.initializeApp();
  analytics = FirebaseAnalytics();
  print("Init Firebase");

  FirebaseAuth auth = FirebaseAuth.instance;

  // Listens to changes to User status (IE sign in/sign out)
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print("User is currently signed out");
    } else {
      print("User ${user.uid} ${user.email} is signed in");

      //save uid
      databaseService.uid = user.uid;

      databaseService.updateUserMessagesSystemType("signin");
      analytics.logLogin();
    }
    //todo add error handling
  });

  PushNotificaitonsManager pushNotifs = new PushNotificaitonsManager();

  pushNotifs.init();

  //print('Message Token:' + FirebaseMessaging().getToken().toString());

  print('App Version:' + appVersion + ' Date:' + appDate);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (_) => runApp(ChangeNotifierProvider(
          create: (context) => ProjectModel(), child: App())));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //if we are not signed in then put up signin
    //else go to app

    analytics.setAnalyticsCollectionEnabled(true);
    print("Analytics Enabled");
    analytics.setCurrentScreen(screenName: 'StartScreen');

    if (databaseService?.uid == '') {
      print("uid null");
      analytics.logTutorialBegin();
      return MaterialApp(
        routes: {'onboard': (context) => MyHomePage()},
        initialRoute: 'onboard',
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
      );
    } else {
      return MaterialApp(
        routes: {'tab': (context) => TabGroupOneTabBarWidget()},
        initialRoute: 'tab',
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
      );
    }
  }
}
