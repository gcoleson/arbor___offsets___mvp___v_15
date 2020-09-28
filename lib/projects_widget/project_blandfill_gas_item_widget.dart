/*
*  project_blandfill_gas_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProjectBLandfillGasItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 360,
      constraints: BoxConstraints.expand(height: 336.57031),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 280,
            //constraints: BoxConstraints.expand(),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  //left: 0,
                  top: 0,
                  //height: 200,
                  child: Image.asset(
                    "assets/images/one-tree-planted-21-copy.png",
                    alignment: Alignment.center,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 3,
                  right: 10,
                  bottom: 0,
                  //height: 30,
                  child: AutoSizeText(
                    "Landfill Gas Capture: Nebraska",
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 21,
            margin: EdgeInsets.only(left: 13, right: 15, bottom: 3),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(right: 82),
                      child: AutoSizeText(
                        "Capture landfill methane",
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: AutoSizeText(
                    "43% Funded",
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 242, 106, 44),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 68, bottom: 1),
            child: AutoSizeText(
              "\$1.22 per pound of carbon removed",
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
