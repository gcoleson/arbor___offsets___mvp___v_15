/*
*  main.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

//import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
//import 'package:arbor___offsets___mvp___v_15/project_detail_widget/project_detail_widget.dart';
//import 'package:arbor___offsets___mvp___v_15/projects_widget/projects_widget.dart';
//import 'package:arbor___offsets___mvp___v_1.5/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:arbor___offsets___mvp___v_15/onboarding_screens/onboard_main_screen.dart';
//import 'package:arbor___offsets___mvp___v_15/shopping_cart/shopping_cart.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
//import 'onboarding_screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  //Boiler plate code ot get firebase initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Listens to changes to User status (IE sign in/sign out)
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print("User is currently signed out");
    } else {
      print("User is signed in");
    }
  });

  // Enabling analytics for Firebase
  FirebaseAnalytics analytics;
  analytics = FirebaseAnalytics();

  runApp(App());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: MyHomePage(title: 'Place order'),
//     );
//   }
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: TabGroupOneTabBarWidget(),
      home: MyHomePage(),
    );
  }
}
