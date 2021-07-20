// @dart=2.9

import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/util/OutlinedText.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

void switchPage(PageController controller, int pageNum) {
  controller.animateToPage(
    pageNum,
    duration: const Duration(milliseconds: 500),
    curve: Curves.ease,
  );
}

Widget onboardingScreen(BuildContext context, String analyticsName, String assetLocation, String header, String footer) {
  var textStyle = AppFonts.introScreenHeadlineText.copyWith(shadows: outlinedText(strokeColor: Colors.black));

  analytics.logEvent(name: 'onboarding_view',
    parameters: filterOutNulls(<String, Object>{
    "onboarding_view": analyticsName,
  })
  );
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Stack(fit: StackFit.expand, children: [
      Image.asset(assetLocation, fit: BoxFit.fill),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top:70, left: 14, right: 14),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: textStyle
            )),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 60, left: 14, right: 14),
            child: Text(
              footer,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          )),
    ]),
  );
}
