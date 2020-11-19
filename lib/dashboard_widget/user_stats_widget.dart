import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/stripe/one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CartItem.dart';
import 'shopping_cart_widget.dart';
import 'UserStats.dart';

/*===============================================================================================
  Stream Builder for User Data
  ================================================================================================*/
StreamBuilder buildUserStats(BuildContext context, UserStats userStats) {
  return StreamBuilder(
    stream: databaseReference
        .collection("users")
        .doc(databaseService.uid)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return CircularProgressIndicator();
      }
      print("User Data Loaded");
      userStats.consecutiveMonths = snapshot.data["consecutiveMonths"];
      userStats.totalMonths = snapshot.data["totalMonths"];
      userStats.totalTrees = snapshot.data["totalTrees"];
      userStats.treesThisMonth = snapshot.data["treesThisMonth"];
      return Column(
        children: [
          buildImpactContainer(userStats.totalTrees, userStats.treesThisMonth),
          buildMonthsInARowContainer(userStats.consecutiveMonths),
          buildTotalMonthsContainer(userStats.totalMonths)
        ],
      );
    },
  );
}

/*===============================================================================================
  User stats: Total Months
  ================================================================================================*/
Container buildTotalMonthsContainer(int totalMonths) {
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
                  //===========================================
                  // Total Months of Impact
                  //===========================================
                  totalMonths.toString(),
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

/*===============================================================================================
  Stream Builder for Months in a row
  ================================================================================================*/
Widget buildMonthsInARowContainer(int consecutiveMonths) {
  print("consecutive months are: " + consecutiveMonths.toString());
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
                  //==============================
                  //Consecutive Months
                  //==============================
                  consecutiveMonths.toString(),
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

/*===============================================================================================
  User stats: Months of Impact
  ================================================================================================*/
Container buildImpactContainer(int totalTrees, int treesThisMonth) {
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
        Row(
          children: [
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
                    margin: EdgeInsets.all(5),
                    child: AutoSizeText(
                      //================================
                      // treesThisMonth
                      //=================================
                      treesThisMonth.toString() + " trees earned this month.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 250, 195, 21),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: AutoSizeText(
                        //========================
                        // total trees
                        //=======================
                        totalTrees.toString() + " all-time!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 195, 21),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
