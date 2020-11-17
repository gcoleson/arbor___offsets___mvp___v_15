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
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics;

const appVersion =
    String.fromEnvironment('APP_VERSION', defaultValue: 'development');
const appDate = String.fromEnvironment('APP_DATE', defaultValue: 'none');

void main() async {
  //Boiler plate code ot get firebase initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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

      //check for user data, if not make a record

    }
    //todo add error handling
  });

  // Enabling analytics for Firebase
  analytics = FirebaseAnalytics();

  print('App Version:' + appVersion + ' Date:' + appDate);
  runApp(ChangeNotifierProvider(
      create: (context) => ProjectModel(), child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //if we are not signed in then put up signin
    //else go to app
    if (databaseService?.uid == null) {
      print("uid null");
      return MaterialApp(
        home: MyHomePage(),
      );
    } else {
      return MaterialApp(
        home: TabGroupOneTabBarWidget(),
      );
    }
  }
}
