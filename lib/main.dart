/*
*  main.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'dart:io';

import 'package:arbor___offsets___mvp___v_15/onboarding_screens/onboard_main_screen.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAnalytics analytics;

DatabaseService databaseService;

void main() async {
  //Boiler plate code ot get firebase initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Enabling analytics for Firebase
  analytics = FirebaseAnalytics();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listens to changes to User status (IE sign in/sign out)
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print("User is currently signed out");
      } else {
        print("User ${user.uid} ${user.email} is signed in");

        //save uid
        databaseService = DatabaseService(uid: user.uid);

        databaseService.updateUserMessagesSystemType("signin");

        //check for user data, if not make a record

      }
      //todo add error handling
    });

    //if we are not signed in then put up signin
    //else go to app
    if (databaseService?.uid == null) {
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
