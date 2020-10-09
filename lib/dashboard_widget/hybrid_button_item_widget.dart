/*
*  hybrid_button_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';

Widget generalButtonItemWidget(String iconName, String iconText) {
  return Container(
    width: 95,
    height: 107,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 95,
            height: 107,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset(iconName, fit: BoxFit.fill),
                  onPressed: () {},
                )),
            Text(iconText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 65, 127, 69),
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                )),
          ],
        ),
      ],
    ),
  );
}
