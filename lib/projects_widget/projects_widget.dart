/*
*  projects_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectsWidget extends StatefulWidget {
  @override
  _ProjectsWidgetState createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  void onItemPressed(BuildContext context) {}

  ProjectData projectData = ProjectData();

  Widget buildProjectListWidget(BuildContext context) {
    try {
      return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection("projects").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          final int messageCount = snapshot.data.docs.length;

          return ListView.builder(
            itemCount: messageCount,
            itemBuilder: (_, int index) {
              final DocumentSnapshot document = snapshot.data.docs[index];
              projectData.brief = document['brief'];
              projectData.description = document['description'];
              projectData.imagemain = document['image-main'];
              projectData.image1 = document['image1'];
              projectData.image2 = document['image2'];
              projectData.image3 = document['image3'];
              projectData.image4 = document['image4'];
              projectData.location = document['location'];
              projectData.maplocal = document['map-local'];
              projectData.percent = document['percent'];
              projectData.sponsor = document['sponsor'];
              projectData.sponsorlogo = document['sponsor-logo'];
              projectData.title = document['title'];
              return ProjectSummaryWidget(projectData);
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

  initProjectData() {
    print('init data');
    projectData.brief = "brief";
    projectData.description = 'description';
    projectData.imagemain =
        "https://firebasestorage.googleapis.com/v0/b/financeapp-2c7b8.appspot.com/o/valparaiso-riverbank-web-scaled.jpg?alt=media&token=f55c40b0-4152-4d9b-9821-2349db9e458c";
    projectData.image1 =
        "https://firebasestorage.googleapis.com/v0/b/financeapp-2c7b8.appspot.com/o/valparaiso-riverbank-web-scaled.jpg?alt=media&token=f55c40b0-4152-4d9b-9821-2349db9e458c";
    projectData.image2 =
        "https://firebasestorage.googleapis.com/v0/b/financeapp-2c7b8.appspot.com/o/valparaiso-riverbank-web-scaled.jpg?alt=media&token=f55c40b0-4152-4d9b-9821-2349db9e458c";
    projectData.image3 =
        "https://firebasestorage.googleapis.com/v0/b/financeapp-2c7b8.appspot.com/o/valparaiso-riverbank-web-scaled.jpg?alt=media&token=f55c40b0-4152-4d9b-9821-2349db9e458c";
    projectData.image4 =
        "https://firebasestorage.googleapis.com/v0/b/financeapp-2c7b8.appspot.com/o/valparaiso-riverbank-web-scaled.jpg?alt=media&token=f55c40b0-4152-4d9b-9821-2349db9e458c";
    projectData.location = 'location';
    projectData.maplocal = GeoPoint(33.781115, -84.299746);
    projectData.percent = 50;
    projectData.sponsor = 'sponsor';
    projectData.sponsorlogo =
        'https://firebasestorage.googleapis.com/v0/b/financeapp-2c7b8.appspot.com/o/SFT-Logo-Long-Color.png?alt=media&token=24f9df3d-a899-47c5-9a09-b13d41db8729';
    projectData.title = 'title';
  }

  @override
  void initState() {
    //initProjectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Projects",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => this.onItemPressed(context),
            icon: Image.asset(
              "assets/images/icons8-account-100.png",
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 65, 127, 69),
      ),
      body: Container(
        height: 600,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 228),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              height: 30,
              child: Text(
                "August 2020",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ),
            Positioned(
              left: 3,
              top: 50,
              right: 1,
              height: 550,
              child: buildProjectListWidget(context),
            ),
          ],
        ),
      ),
    );
  }
}
