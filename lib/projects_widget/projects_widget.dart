/*
*  projects_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Projects",
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
    );
  }
}
