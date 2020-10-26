/*
*  projects_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';

class ProjectsWidget extends StatelessWidget {
  void onItemPressed(BuildContext context) {}

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
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) =>
                    ProjectBLandfillGasItemWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
