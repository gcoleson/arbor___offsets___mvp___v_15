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
//import 'onboarding_screens/onboarding_screen.dart';
//import 'package:arbor___offsets___mvp___v_15/shopping_cart/checkout_entry.dart';

//Firebase Imports
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Stripe Imports
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseAnalytics analytics;

DatabaseService databaseService;

void main() async {
  String text = "Click the button to start the payment";
  double totalCost = 10.0;
  double tip = 1.0;
  double tax = 0.0;
  double taxPercent = 0.2;
  int amount = 0;
  bool showSpinner = false;
  String url =
      "https://us-central1-demostripe-b9557.cloudfunctions.net/StripePI";
  //Boiler plate code ot get firebase initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Listens to changes to User status (IE sign in/sign out)
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print("User is currently signed out");
    } else {
      print("User ${user.uid} is signed in");

      //save uid
      databaseService = DatabaseService(uid: user.uid);

      databaseService.updateUserMessagesSystemType("signin");
    }
    //todo add error handling
  });

  // Enabling analytics for Firebase
  analytics = FirebaseAnalytics();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //if we are not signed in then put up signin
    //else go to app
    if (databaseService.uid == null) {
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
