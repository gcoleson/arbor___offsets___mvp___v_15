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
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  void onItemPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        //constraints: BoxConstraints.expand(),
        //decoration: BoxDecoration(
        //  color: Color.fromARGB(255, 237, 236, 228),
        //),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildImpactContainer(),
              buildMonthsInARowContainer(),
              buildTotalMonthsContainer(),
              buildLiveClimatePositveAlign(),
              buildOffsetPurchaseListContainer(),
              buildCheckoutButtonContainer(),
            ],
          )
        ],
      ),
    );
  }

  Container buildCheckoutButtonContainer() {
    return Container(
      width: 300,
      height: 50,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: Radii.k8pxRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            //margin: EdgeInsets.only(left: 100, right: 100),
            child: AutoSizeText(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 416,
            height: 190,
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
                    itemCount: 3,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      itemCount: 3,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    itemCount: 3,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
        //height: 400,
        margin: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
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
            Row(children: [
              Container(
                  height: 90,
                  width: 90,
                  margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(9, (index) {
                        return Center(
                          child: Image.asset(
                            "assets/images/icons8-oak-tree-100-2-copy-9.png",
                            //fit: BoxFit.,
                          ),
                        );
                      }))),
              Container(
                  height: 90,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          //height: 30,
                          //width: 50,
                          margin: EdgeInsets.all(5),
                          child: AutoSizeText(
                            "9 trees earned this month.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 250, 195, 21),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          //alignment: Alignment.center,
                          child: Container(
                            //height: 30,
                            //width: 50,
                            margin: EdgeInsets.all(5),
                            child: AutoSizeText(
                              "38 all-time!",
                              //minFontSize: 12,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 250, 195, 21),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      ]))
            ])
          ],
        ));
  }
}
