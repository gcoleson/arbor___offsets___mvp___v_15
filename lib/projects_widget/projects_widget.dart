/*
*  projects_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

//import 'dart:js';

import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'arbor_explanation.dart';
import '../main.dart';

Map<int, ProjectData> projectDataMap = Map();

class ProjectsWidget extends StatefulWidget {
  @override
  _ProjectsWidgetState createState() => _ProjectsWidgetState();
}

class ProjectModel extends ChangeNotifier {
  int value = 0;

  void selectChange() {
    value += 1;
    print('notifyListeners:$value');
    notifyListeners();
  }
}

Future<String> checkFirstTimeOpen() async {
  String value;
  try {
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data.txt');
    value = await file.readAsString();
  } catch (e) {
    value = "error";
  }
  return value;
}

Future firstTimeOpen(String text, BuildContext context) async {
  showDialog(
    context: context,
    builder: (_) => new CupertinoAlertDialog(
      title: new Text("Pick a Project"),
      content: new Text(
          "Choose which climate project you'd like to support with your purchases."),
      actions: [
        CupertinoDialogAction(
          child: Text("Got it"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/data.txt');
  await file.writeAsString(text);
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  void onItemPressed(BuildContext context) {}

  Widget buildProjectListWidget(BuildContext context) {
    try {
      analytics.logEvent(name: 'ProjectScreen');

      return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection("projects").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          final int messageCount = snapshot.data.docs.length;

          return ListView.builder(
            itemCount: messageCount,
            itemBuilder: (_, int index) {
              //we might be returning here, check for data
              ProjectData projectData;

              if (!projectDataMap.containsKey(index)) {
                projectData = ProjectData();

                DocumentSnapshot document = snapshot.data.docs[index];

                projectData.brief = document['brief'];
                projectData.description = document['description'];
                projectData.imagemain = document['image-main'];
                projectData.image1 = testDBForField(document, 'image1');
                projectData.image2 = testDBForField(document, 'image2');
                projectData.image3 = testDBForField(document, 'image3');
                projectData.image4 = testDBForField(document, 'image4');
                projectData.location = document['location'];
                projectData.maplocal = document['map-local'];
                projectData.percent = document['percent'];
                projectData.sponsor = document['sponsor'];
                projectData.sponsorlogo = document['sponsor-logo'];
                projectData.title = document['title'];
                projectData.projectId = document.id;

                projectData.projectnumber =
                    testDBForField(document, 'projectnumber') ?? 0;

                if (projectData.projectnumber != 0 &&
                    userdata.selectedprojectnumber != 0 &&
                    projectData.projectnumber == userdata.selectedprojectnumber)
                  projectData.selected = true;
                else
                  projectData.selected = false;

                //add to map for referencing selected or not
                projectDataMap.putIfAbsent(index, () => projectData);
              } else {
                projectData = projectDataMap[index];
              }

              return ProjectSummaryWidget(index, projectData);

              // return Text(
              //   "Tap a project name for full details. Tap an image to select a project",
              //   style: AppFonts.projectLabelSubhead,
              // );
            },
          );
        },
      );
    } catch (error) {
      print('project db error');
      print(error.toString());
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFirstTimeOpen().then((value) {
      if (value == "error") {
        firstTimeOpen("opened", context);
      } else {
        print(value);
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Projects',
          textAlign: TextAlign.center,
          style: AppFonts.navBarHeader,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 65, 127, 69),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 9, 11, 9),
              child: Text(
                "Tap a project name for full details. Tap an image to select a project",
                style: AppFonts.projectLabelSubhead,
              ),
            ),
            Flexible(
              child: Stack(
                children: [
                  loadUserData(context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildProjectListWidget(context),
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
