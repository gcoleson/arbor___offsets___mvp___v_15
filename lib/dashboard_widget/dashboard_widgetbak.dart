/*
*  dashboard_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/dashboard_widget/huge_package_heh_heh_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/hybrid_button_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/long_flight_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/medium_flight_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/medium_package_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/sedan_button_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/short_flight_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/small_package_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/suvbutton_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  void onItemPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Arbor",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => this.onItemPressed(context),
            icon: Image.asset(
              "assets/images/icons8-account-100.png",
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 65, 127, 69),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 228),
        ),
        //child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildImpactContainer(),
            //buildMonthsInARowContainer(),
            //buildTotalMonthsContainer(),
            //buildLiveClimatePositveAlign(),
            //buildOffsetPurchaseListContainer(),
            //buildCheckoutButtonContainer(),
          ],
        ),
      ),
      //),
    );
  }

  Container buildCheckoutButtonContainer() {
    return Container(
      width: 344,
      height: 50,
      margin: EdgeInsets.only(bottom: 35),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: Radii.k8pxRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(left: 133, right: 134),
            child: Text(
              "Checkout",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w400,
                fontSize: 17,
                letterSpacing: -0.408,
                height: 1.29412,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildOffsetPurchaseListContainer() {
    return Container(
      height: 601,
      margin: EdgeInsets.only(left: 1, top: 16, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 416,
            height: 184,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Text(
                    "Eliminate Fuel Impact:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w300,
                      fontSize: 21,
                    ),
                  ),
                ),
                Container(
                  width: 382,
                  margin: EdgeInsets.only(left: 4, top: 2),
                  child: Text(
                    "Remove climate impact from an average tank of gas for:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  width: 383,
                  height: 108,
                  margin: EdgeInsets.only(left: 14, top: 9),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 108,
                      childAspectRatio: 1.13684,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) => HybridButtonItemWidget(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 414,
            height: 181,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      "Eliminate Travel Impact:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w300,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, top: 2),
                  child: Text(
                    "Remove climate impact from an average flight between:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 383,
                    height: 106,
                    margin: EdgeInsets.only(left: 14, top: 6),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 106,
                        childAspectRatio: 1.12766,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) => ShortFlightItemWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 414,
            height: 181,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(
                      "Eliminate Package Delivery:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w300,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, top: 2),
                  child: Text(
                    "Remove climate impact from a typical shipment that is:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  height: 106,
                  margin: EdgeInsets.only(left: 14, top: 6),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 106,
                      childAspectRatio: 1.12766,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) => SmallPackageItemWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align buildLiveClimatePositveAlign() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(left: 5, top: 31),
        child: Text(
          "Live Climate Positive: ",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 65, 127, 69),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  Container buildTotalMonthsContainer() {
    return Container(
      height: 57,
      margin: EdgeInsets.only(right: 1),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: 8,
            right: 0,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 93, 187, 71),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(128, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(),
            ),
          ),
          Positioned(
            left: 24,
            top: 8,
            right: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "5",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 195, 21),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      "total months of impact",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildMonthsInARowContainer() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 1, top: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: -0,
            right: 0,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 93, 187, 71),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(128, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(),
            ),
          ),
          Positioned(
            left: 22,
            top: -1,
            right: 11,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "2",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 195, 21),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      "months in a row of impact",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildImpactContainer() {
    return Container(
      height: 189,
      margin: EdgeInsets.only(left: 5, top: 30, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Your Impact:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 65, 127, 69),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
            ),
          ),
          Container(
            height: 89,
            margin: EdgeInsets.only(left: 4, top: 15, right: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Image.asset(
                    "assets/images/icons8-oak-tree-100-2-copy-9.png",
                    fit: BoxFit.none,
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 0,
                  right: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 34,
                        top: 0,
                        right: 0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Image.asset(
                                "assets/images/icons8-oak-tree-100-2-copy-9.png",
                                fit: BoxFit.none,
                              ),
                            ),
                            Positioned(
                              left: 15,
                              top: 0,
                              right: 0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 34,
                                    top: 0,
                                    right: 0,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  width: 41,
                                                  height: 41,
                                                  child: Image.asset(
                                                    "assets/images/icons8-oak-tree-100-2-copy-9.png",
                                                    fit: BoxFit.none,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  width: 41,
                                                  height: 41,
                                                  margin: EdgeInsets.only(
                                                      left: 15, top: 7),
                                                  child: Image.asset(
                                                    "assets/images/icons8-oak-tree-100-2-copy-9.png",
                                                    fit: BoxFit.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          right: 0,
                                          child: Text(
                                            "9 trees earned this month.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 250, 195, 21),
                                              fontFamily: "Raleway",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 36,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 48,
                                    child: Image.asset(
                                      "assets/images/icons8-oak-tree-100-2-copy-9.png",
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 48,
                        child: Image.asset(
                          "assets/images/icons8-oak-tree-100-2-copy-9.png",
                          fit: BoxFit.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 42,
            margin: EdgeInsets.only(left: 32, top: 7, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 41,
                    height: 41,
                    child: Image.asset(
                      "assets/images/icons8-oak-tree-100-2-copy-9.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 41,
                    height: 41,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset(
                      "assets/images/icons8-oak-tree-100-2-copy-9.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 41,
                    height: 41,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset(
                      "assets/images/icons8-oak-tree-100-2-copy-9.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      "38 all-time!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 250, 195, 21),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
