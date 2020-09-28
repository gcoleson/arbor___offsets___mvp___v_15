/*
*  project_detail_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProjectDetailWidget extends StatelessWidget {
  void onItemPressed(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Project Details",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () => this.onItemPressed(context),
          icon: Image.asset(
            "assets/images/icons8-left-50.png",
          ),
        ),
        backgroundColor: Color.fromARGB(255, 65, 127, 69),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: AppColors.ternaryBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 283,
              margin: EdgeInsets.only(left: 10, top: 75, right: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 259,
                    margin: EdgeInsets.only(top: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 259,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 5,
                                color: Color.fromARGB(255, 250, 195, 21),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.asset(
                              "assets/images/one-tree-planted-21-4.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 229,
                          right: 17,
                          child: Text(
                            "Supporting",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color.fromARGB(255, 250, 195, 21),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 45,
                      height: 8,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            child: Image.asset(
                              "assets/images/dot-3-2.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 8,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  "assets/images/dot-3-3.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.only(right: 1),
                            child: Opacity(
                              opacity: 0.3,
                              child: Image.asset(
                                "assets/images/dot-3-3.png",
                                fit: BoxFit.none,
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
            Container(
              height: 76,
              margin: EdgeInsets.only(left: 10, top: 9, right: 13),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 68,
                    bottom: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "Reforestation Project: Tennessee",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w500,
                              fontSize: 21,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Sevierville, TN",
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
                      ],
                    ),
                  ),
                  Positioned(
                    left: 2,
                    right: 128,
                    child: Text(
                      "\$0.78/pound of carbon removed",
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
                ],
              ),
            ),
            Container(
              height: 66,
              margin: EdgeInsets.only(left: 10, top: 6, right: 13),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 3,
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.ternaryBackground,
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: 16,
                            right: 16,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(51, 120, 120, 128),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                              child: Container(),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            child: Container(
                              width: 302,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 242, 106, 44),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 41,
                    right: 0,
                    child: Text(
                      "92% Funded",
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
              margin: EdgeInsets.only(left: 17, top: 8, right: 8),
              child: Text(
                "Funding the replanting of 550 acres in Eastern TN, boardering the Great Smokey Mountains National Park. \n\nEach dollar funded goes to purchasing tree seedlings to replant the forest. Every tree planted will remove 40-50 tons of carbon over its lifetime—in addition to rebuilding the forest habitat for native species. The forest is placed in a conservation easement to ensure the trees are never cut down once planted. ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 2, 2),
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 21,
              margin: EdgeInsets.only(left: 14, top: 24, right: 11),
              child: Row(
                children: [
                  Text(
                    "Visit Project Sponsor",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Text(
                    ">",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
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
