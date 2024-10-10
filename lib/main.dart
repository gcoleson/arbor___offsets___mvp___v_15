/*
*  main.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by gregc
*  Copyright © 2020 412 Technology. All rights reserved.
    */


import 'package:arbor___offsets___mvp___v_15/shopping_cart/shopping_cart.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Place order'),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabGroupOneTabBarWidget(),
      //home: MyHomePage(),
    );
  }
}
