/*
*  project_blandfill_gas_item_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Greg
*  Copyright © 2020 412 Technology. All rights reserved.
    */
// @dart=2.9

import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/project_detail_widget/project_detail_widget.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/projects_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

var loadingBuilder2 =
    (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes
          : null,
    ),
  );
};

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
      return AppColors.highlightYellow;
    } else {
      //turn border off
      return AppColors.Black;
    }
  }

  void toggleProjectSelected() {
    if (projectData.selected == false) {
      projectData.selected = true;

      //toggle all other projects off
      projectDataMap.forEach((key, value) {
        if (key != index) {
          value.selected = false;
          print('deselected:$key:${value.selected}:${value.title}');
        }
      });

      userdata.selectedprojectnumber = projectData.projectnumber;
      userdata.selectedProjectId = projectData.projectId;
      userdata.selectedProjectTitle = projectData.title;
      analytics.logEvent(name: 'SlectProject', parameters: {
        'number': projectData.projectnumber,
        'title': projectData.title,
        'sponsor': projectData.sponsor
      });

      //turn border on
      //turn selected text on
      //write to db

    } else {
      //don't allow deselecting projects
      //projectData.selected = false;
      //userdata.selectedprojectnumber = 0;

      //turn border off
      //turn selected text off
      //write to db
    }
    print('Update user data slected project:${userdata.selectedprojectnumber}');
    databaseService.updateUserData(userdata, false);

    var counter = context.read<ProjectModel>();
    counter.selectChange();
  }

  @override
  Widget build(BuildContext context) {
    var imageDummy = projectData.imagemain;

    return Consumer<ProjectModel>(builder: (context, projectdata, child) {
      //add true or false statement, boolean
      return Container(
        constraints: BoxConstraints.expand(height: 360),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            //this is where the padding goes...
            Container(
              height: 280,
              child: Container(
                height: 280,
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          imageDummy,
                          loadingBuilder: loadingBuilder2,
                          fit: BoxFit.fill,
                          height: 280,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              toggleProjectSelected();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                width: 3,
                                color: getProductBorderSelectColor(),
                              ),
                            ),
                          )),
                      Positioned(
                        left: 3,
                        right: 10,
                        bottom: 10,
                        child: AutoSizeText(
                          projectData.selected ? "Supporting" : '',
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          style: AppFonts.supportingLabel,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                analytics.logEvent(name: 'DetailProject', parameters: {
                  'number': projectData.projectnumber,
                  'title': projectData.title
                });

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
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 386,
        height: 30,
        child: AutoSizeText(
          projectData.title,
          maxLines: 1,
          style: AppFonts.projectLabelHeadline,
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
            flex: 3,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 44,
                maxWidth: 389,
              ),
              child: Container(
                height: 40,
                child: AutoSizeText(
                  projectData.brief,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: AppFonts.projectLabelSubhead,
                ),
              ),
            )),
        Expanded(
          child: AutoSizeText(
            "${projectData.percent}" "% Funded",
            maxLines: 1,
            textAlign: TextAlign.right,
            style: AppFonts.percentFunded,
          ),
        ),
      ]),
    );
  }
}
