/*
*  project_blandfill_gas_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/project_detail_widget/project_detail_widget.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/projects_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectSummaryWidget extends StatefulWidget {
  final ProjectData projectData;
  final index;

  ProjectSummaryWidget(this.index, this.projectData);

  @override
  _ProjectSummaryWidgetState createState() =>
      _ProjectSummaryWidgetState(this.index, this.projectData);
}

class _ProjectSummaryWidgetState extends State<ProjectSummaryWidget> {
  final ProjectData projectData;
  final index;

  _ProjectSummaryWidgetState(this.index, this.projectData);

  Color getProductBorderSelectColor() {
    if (projectData.selected) {
      //turn border on
      return Color.fromARGB(255, 250, 195, 21);
    } else {
      //turn border off
      return Color.fromARGB(255, 0, 0, 0);
    }
  }

  void toggleProjectSelected() {
    if (projectData.selected == false) {
      projectData.selected = true;

      //toggle all other projects off
      projectDataMap.forEach((key, value) {
        if (key != index) {
          print('removed:$key');
          print(value);
          value.selected = false;
        }
      });

      //turn border on
      //turn selected text on
      //write to db
    } else {
      projectData.selected = false;

      //turn border off
      //turn selected text on
      //write to db
    }

    //notify of changes
    ProjectModel().selectChange();
  }

  @override
  Widget build(BuildContext context) {
    var imageDummy = projectData.imagemain;

    return Consumer<ProjectModel>(builder: (context, projectdata, child) {
      return Container(
        constraints: BoxConstraints.expand(height: 360),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              height: 280,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 2),
              child: Container(
                height: 280,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 3,
                      color: getProductBorderSelectColor(),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                toggleProjectSelected();
                              });
                            },
                            child: Container(
                              height: 280,
                              child: Image.network(
                                imageDummy,
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              ),
                            )),
                      ),
                      Positioned(
                        left: 3,
                        right: 10,
                        bottom: 10,
                        child: AutoSizeText(
                          projectData.selected ? "Selected" : '',
                          textAlign: TextAlign.right,
                          maxLines: 1,
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
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProjectDetailWidget(context, projectData)));
                });
              },
              child: Column(
                children: [
                  ProjectTitleWidget(projectData: projectData),
                  ProjectInfoWidget(projectData: projectData),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ProjectTitleWidget extends StatelessWidget {
  const ProjectTitleWidget({
    Key key,
    @required this.projectData,
  }) : super(key: key);

  final ProjectData projectData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
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
    );
  }
}

class ProjectInfoWidget extends StatelessWidget {
  const ProjectInfoWidget({
    Key key,
    @required this.projectData,
  }) : super(key: key);

  final ProjectData projectData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 13, right: 15, bottom: 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: AutoSizeText(
                  projectData.brief,
                  //maxLines: 1,
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
    );
  }
}
