/*
*  huge_package_heh_heh_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';

class HugePackageHehHehItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 106,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 94,
              height: 106,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
              ),
              child: Container(),
            ),
          ),
          Positioned(
            right: 6,
            bottom: 14,
            child: Text(
              "Large (10+ lbs)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 65, 127, 69),
                fontFamily: "Raleway",
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
          Positioned(
            top: 7,
            right: 5,
            child: Image.asset(
              "assets/images/icons8-in-transit-100-copy-2.png",
              fit: BoxFit.none,
            ),
          ),
        ],
      ),
    );
  }
}
