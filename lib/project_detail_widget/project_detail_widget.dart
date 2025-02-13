// @dart=2.9

/*
*  project_detail_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Greg
*  Copyright © 2020 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class ProjectDetailWidget extends StatefulWidget {
  ProjectDetailWidget(this.context, this.projectData);
  final ProjectData projectData;
  final BuildContext context;

  @override
  _ProjectDetailWidgetState createState() =>
      _ProjectDetailWidgetState(context, this.projectData);
}

class _ProjectDetailWidgetState extends State<ProjectDetailWidget> {
  _ProjectDetailWidgetState(BuildContext context, this.projectData);
  final ProjectData projectData;

  void onItemPressed(BuildContext context) => Navigator.pop(context);

  List<Widget> imageSliders = [];

  @override
  void initState() {
    //build list of image widgets
    List<String> imgList = [
      projectData.imagemain,
      projectData.image1,
      projectData.image2,
      projectData.image3,
      projectData.image4,
    ];

    imgList.forEach((element) {
      if (element != null) {
        Widget test = new Image.network(element,
            loadingBuilder: loadingBuilder2, fit: BoxFit.cover, width: 1000.0);
        imageSliders.add(test);
      }
    });

    super.initState();
  }

  _launchURL() async {
    final url =
        "https://www.google.com/maps/@${widget.projectData.maplocal.latitude},${widget.projectData.maplocal.longitude},17z";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: imageSliders,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Project Details",
            textAlign: TextAlign.center,
            style: AppFonts.navBarHeader,
          ),
          leading: IconButton(
            onPressed: () => this.onItemPressed(context),
            icon: Image.asset(
              "assets/images/icons8-left-50.png",
            ),
          ),
          backgroundColor: AppColors.primaryDarkGreen,
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: 2250,
            margin: EdgeInsets.only(left: 1, top: 8, right: 5),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 283, child: buildCarouselSlider()),
                Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 10, top: 9, right: 10),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 1,
                        top: 0,
                        right: 1,
                        bottom: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 2),
                              child: AutoSizeText(
                                projectData.title,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: AppFonts.projectLabelHeadline,
                              ),
                            ),
                            Container(
                              height: 21,
                              margin: EdgeInsets.only(left: 2),
                              child: Row(
                                children: [
                                  Container(
                                    child: AutoSizeText(
                                      "${widget.projectData.location} ",
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      style: AppFonts.projectLabelSubhead,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      _launchURL();
                                    },
                                    child: Text("Map  >",
                                        textAlign: TextAlign.right,
                                        style: AppFonts.projectLabelSubhead),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        child: Text("In partnership with: ",
                            textAlign: TextAlign.center,
                            style: AppFonts.sectionLabels)),
                    Container(
                      child: Image.network(widget.projectData.sponsorlogo,
                          loadingBuilder: loadingBuilder2,
                          width: 125,
                          fit: BoxFit.fill),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: LinearPercentIndicator(
                    percent: widget.projectData.percent.toDouble() / 100,
                    progressColor: Color.fromARGB(255, 0, 122, 255),
                    lineHeight: 20,
                    center: AutoSizeText(
                      "${widget.projectData.percent}% Funded",
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: AppFonts.projectLabelHeadline,
                    ),
                  ),
                ),
                Html(
                  data: projectData.description,
                ),
              ],
            ),
          ),
        ));
  }
}
