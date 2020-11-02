/*
*  project_blandfill_gas_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/project_detail_widget/project_detail_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProjectSummaryWidget extends StatefulWidget {
  final ProjectData projectData;

  ProjectSummaryWidget(this.projectData);

  @override
  _ProjectSummaryWidgetState createState() =>
      _ProjectSummaryWidgetState(this.projectData);
}

class _ProjectSummaryWidgetState extends State<ProjectSummaryWidget> {
  final ProjectData projectData;

  _ProjectSummaryWidgetState(this.projectData);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 336.57031),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            height: 280,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProjectDetailWidget(context, projectData)));
                        });
                      },
                      child: Image.network(
                        projectData.imagemain,
                        alignment: Alignment.center,
                        height: 200,
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  left: 3,
                  right: 10,
                  bottom: 0,
                  child: AutoSizeText(
                    projectData.title,
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
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(right: 82),
                      child: AutoSizeText(
                        projectData.brief,
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
                    "${projectData.percent}" "% Funded",
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
              "",
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
