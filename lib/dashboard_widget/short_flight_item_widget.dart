/*
*  short_flight_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';

class ShortFlightItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 106,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
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
            left: 0,
            top: 39,
            bottom: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 28,
                    height: 28,
                    margin: EdgeInsets.only(left: 33),
                    child: Image.asset(
                      "assets/images/icons8-airplane-take-off-100-copy.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 94,
                    child: Text(
                      "New York & Chicago (2 hrs)",
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
