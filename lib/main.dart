/*
*  main.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

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
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const appVersion = String.fromEnvironment('APP_VERSION', defaultValue: '.1');
const appDate = String.fromEnvironment('APP_DATE', defaultValue: 'none');

void main() async {
  print("App Starting");

  //Boiler plate code ot get firebase initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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
    }
    //todo add error handling
  });

  PushNotificaitonsManager pushNotifs = new PushNotificaitonsManager();

  pushNotifs.init();

  print('Message Token:' + FirebaseMessaging().getToken().toString());

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

    FirebaseAnalytics analytics = FirebaseAnalytics();
    print("Init Analytics");

    analytics.setAnalyticsCollectionEnabled(true);
    analytics.setCurrentScreen(screenName: 'testscreen');
    analytics.logEvent(name: "TestLog");

    if (databaseService?.uid == null) {
      print("uid null");
      return MaterialApp(
        routes: {'home': (context) => MyHomePage()},
        initialRoute: 'home',
        //home: MyHomePage(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
      );
    } else {
      return MaterialApp(
        routes: {'tab': (context) => TabGroupOneTabBarWidget()},
        initialRoute: 'tab',
        //home: TabGroupOneTabBarWidget(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
      );
    }
  }
}
