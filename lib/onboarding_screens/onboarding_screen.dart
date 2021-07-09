// @dart=2.9

import 'package:arbor___offsets___mvp___v_15/entry_screens/login.dart';
import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:arbor___offsets___mvp___v_15/util/CustomButton.dart';
import 'package:arbor___offsets___mvp___v_15/util/ImageTextField.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

void switchPage(PageController controller, int pageNum) {
  controller.animateToPage(
    pageNum,
    duration: const Duration(milliseconds: 500),
    curve: Curves.ease,
  );
}

Widget myPage1Widget(BuildContext context) {
  analytics.logEvent(name: 'Onboarding_1');
  return Container(
    child: Stack(fit: StackFit.expand, children: [
      Image.asset("assets/images/backgroundimageGroupCity@3x.png",
          fit: BoxFit.fill),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30, left: 14, right: 14),
            child: Text(
              "All modern lifestyles have a negative climate impact.",
              textAlign: TextAlign.center,
              style: AppFonts.introScreenHeadlineText,
            )),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 60, left: 14, right: 14),
            child: Text(
              "Arbor makes it easy to eliminate yours.",
              textAlign: TextAlign.center,
              style: AppFonts.introScreenHeadlineText,
            ),
          )),
    ]),
  );
}

Widget myPage2Widget(BuildContext context) {
  analytics.logEvent(name: 'Onboarding_2');
  return Container(
    child: Stack(fit: StackFit.expand, children: [
      Image.asset("assets/images/backgroundImageGroupSprout@3x.png",
          fit: BoxFit.fill),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: AppFonts.navBarHeader,
            )),
      ), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 100, left: 13, right: 13),
            child: Text(
              "Just pick a project you love ...",
              textAlign: TextAlign.center,
              style: AppFonts.introScreenHeadlineText,
            ),
          ))
    ]),
  );
}

Widget myPage3Widget(BuildContext context) {
  analytics.logEvent(name: 'Onboarding_3');
  return Container(
    child: Stack(fit: StackFit.expand, children: [
      Image.asset("assets/images/mountains-919040.png", fit: BoxFit.fill),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(""),
          )), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 100, left: 10, right: 10),
            child: Text(
                "... and eliminate your impact with the tap of a button!",
                textAlign: TextAlign.center,
                style: AppFonts.introScreenHeadlineText),
          ))
    ]),
  );
}

Future<void> _showDialog1(BuildContext context, String errorMessage) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(errorMessage),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}






