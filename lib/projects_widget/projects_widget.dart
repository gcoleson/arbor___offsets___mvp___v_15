/*
*  projects_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

dynamic testDBForField(DocumentSnapshot doc, String field) {
  Map<String, dynamic> test = doc.data();

  for (var entry in test.entries) {
    if (entry.key == field) {
      return entry.value;
    }
  }
  return null;
}

Map<int, ProjectData> projectDataMap = Map();

class ProjectsWidget extends StatefulWidget {
  @override
  _ProjectsWidgetState createState() => _ProjectsWidgetState();
}

class ProjectModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  //final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  //UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  //int get totalPrice => _items.length * 42;

  void selectChange() {
    print('notifyListeners');
    notifyListeners();
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  /* void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
 */
  /// Removes all items from the cart.
/*   void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
 */
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  void onItemPressed(BuildContext context) {}

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
              ProjectData projectData = ProjectData();

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
              projectData.selected = document['selected'];

              //add to map for referencing selected or not
              projectDataMap.putIfAbsent(index, () => projectData);

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
          //color: Color.fromARGB(255, 237, 236, 228),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          children: [
            /*Positioned(
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
        ),*/
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
