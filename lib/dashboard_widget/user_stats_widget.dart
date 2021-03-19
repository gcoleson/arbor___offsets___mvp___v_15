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
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

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
      try {
        userStats.consecutiveMonths = snapshot.data["consecutiveMonths"];

        userStats.totalMonths = snapshot.data["totalMonths"];

        var dummy1;

        dummy1 = snapshot.data["totalTrees"];

        if (dummy1 is int) {
          userStats.totalTrees = dummy1;
        } else {
          userStats.totalTrees = dummy1.toInt();
        }

        var dummy2;
        dummy2 = snapshot.data["treesThisMonth"];

        if (dummy2 is int) {
          userStats.treesThisMonth = dummy2;
        } else {
          userStats.treesThisMonth = dummy2.toInt();
        }

        print("stats");
        return Column(
          children: [
            buildImpactContainer(
                userStats.totalTrees, userStats.treesThisMonth),
            buildMonthsInARowContainer(userStats.consecutiveMonths),
            buildTotalMonthsContainer(userStats.totalMonths)
          ],
        );
      } catch (error) {
        print(error.toString());

        return Column(
          children: [
            buildImpactContainer(0, 0),
            buildMonthsInARowContainer(0),
            buildTotalMonthsContainer(0)
          ],
        );
      }
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
                  child: AutoSizeText(
                    "total months of impact",
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: AppFonts.monthlyImpactText,
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
Container buildMonthsInARowContainer(int consecutiveMonths) {
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
                  child: AutoSizeText(
                    "months in a row of impact",
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: AppFonts.monthlyImpactTextSmall,
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

/* Widget buildMonthsInARowContainer(int consecutiveMonths) {
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
                  child: AutoSizeText(
                    "months in a row of impact",
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: AppFonts.monthlyImpactText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
} */

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
            "Your Climate Impact:",
            textAlign: TextAlign.left,
            style: AppFonts.screenSubhead,
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
                    children: List.generate(treesThisMonth.toInt(), (index) {
                      return Center(
                        child: Image.asset(
                          "assets/images/icons8-oak-tree-100-2-copy-9.png",
                          //fit: BoxFit.,
                        ),
                      );
                    }))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 34,
                          color: Color.fromARGB(255, 250, 195, 21),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700,
                        ),
                        //================================
                        // treesThisMonth
                        //=================================
                        children: <TextSpan>[
                          new TextSpan(
                            text: treesThisMonth.toString() + " ",
                            style: TextStyle(color: AppColors.highlightYellow),
                          ),
                          new TextSpan(
                            text: "Arbor trees earned this month",
                            style: TextStyle(color: AppColors.primaryDarkGreen),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 34,
                            color: Color.fromARGB(255, 250, 195, 21),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700,
                          ),
                          //================================
                          // treesThisMonth
                          //=================================
                          children: <TextSpan>[
                            new TextSpan(
                              text: totalTrees.toString(),
                              style:
                                  TextStyle(color: AppColors.highlightYellow),
                            ),
                            new TextSpan(
                              text: " all-time!",
                              style:
                                  TextStyle(color: AppColors.primaryDarkGreen),
                            )
                          ],
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
