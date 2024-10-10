/*
*  user_account_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by gregc
*  Copyright © 2020 412 Technology. All rights reserved.
*/

import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';

class UserAccountWidget extends StatelessWidget {
  void onChangeCopyPressed(BuildContext context) {}

  void onItemPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Profile",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 1066,
                height: 277,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 129,
                        child: Text(
                          "need to:\na/ signin page\nb/signup page\nc/ checkout page(s)",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 2, 2),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 804, top: 101, right: 215),
                      child: Text(
                        "Ed T.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700,
                          fontSize: 21,
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 42,
                        height: 14,
                        margin: EdgeInsets.only(right: 220),
                        child: FlatButton(
                          onPressed: () => this.onChangeCopyPressed(context),
                          color: Color.fromARGB(0, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          textColor: Color.fromARGB(255, 65, 127, 69),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Change",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 65, 127, 69),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 804),
                        child: Text(
                          "Member since July 2020",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 2, 2),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 314,
              margin: EdgeInsets.only(top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 57,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 57,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 216, 216, 216),
                              border: Border.all(
                                width: 3,
                                color: Color.fromARGB(255, 250, 195, 21),
                              ),
                            ),
                            child: Container(),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 8,
                          right: 14,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 286,
                                  height: 49,
                                  child: Text(
                                    "Change Email",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 127, 69),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "v",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 65, 127, 69),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 44,
                    margin: EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(92, 60, 60, 67),
                            ),
                            child: Container(),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          right: 137,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "New Email",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: "SF Pro Text",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    letterSpacing: -0.408,
                                    height: 1.29412,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 129,
                                  height: 22,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Positioned(
                                        right: 5,
                                        child: Image.asset(
                                          "assets/images/cursor.png",
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 4,
                                        child: Text(
                                          "Enter New Email",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(92, 60, 60, 67),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Positioned(
                                left: 17,
                                child: Text(
                                  "Confirm New Email",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                        ),
                        Positioned(
                          right: 112,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Positioned(
                                right: 6,
                                child: Image.asset(
                                  "assets/images/cursor.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 4,
                                child: Text(
                                  "Re-enter New Email",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 44,
                    margin: EdgeInsets.only(top: 21, right: 2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(92, 60, 60, 67),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Positioned(
                                left: 19,
                                child: Text(
                                  "Confirm Password",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                        ),
                        Positioned(
                          left: 153,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Positioned(
                                right: 2,
                                child: Image.asset(
                                  "assets/images/cursor.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 4,
                                child: Text(
                                  "Password",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 35, top: 11, right: 36),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 134),
                          child: Text(
                            "Change",
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
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 58, right: 59, bottom: 15),
                    child: Text(
                      "We’ll send you an email to verify your new email address.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 127, 69),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 57,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 250, 195, 21),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 34,
                    margin: EdgeInsets.only(left: 14, top: 8, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Change Payment",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 65, 127, 69),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "v",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color.fromARGB(255, 65, 127, 69),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 85, top: 58),
                      child: Text(
                        "this will come from Stripe. ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "SF Pro Text",
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          letterSpacing: -0.408,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 57,
              margin: EdgeInsets.only(top: 144),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 14, top: 8),
                    child: Text(
                      "Replay Tutorial",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 127, 69),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 15),
                    child: Text(
                      ">",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 127, 69),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 57,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 14, top: 8),
                    child: Text(
                      "Contact Us",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 127, 69),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 15),
                    child: Text(
                      ">",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 127, 69),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
