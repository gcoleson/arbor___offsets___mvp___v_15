/*
*  project_detail_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/services/database.dart';
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

  final double projectPercentage = .92;

  List<Widget> imageSliders;

  @override
  void initState() {
    //build list of image widgets
    List<String> imgList = [
      projectData.image1,
      projectData.image2,
      projectData.image3,
      projectData.image4,
    ];

    imageSliders = imgList
        .map((item) => Image.network(item, fit: BoxFit.cover, width: 1000.0))
        .toList();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                )),
            Container(
              height: 76,
              margin: EdgeInsets.only(left: 10, top: 9, right: 10),
              child: Stack(
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
                          child: AutoSizeText(
                            widget.projectData.brief,
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
                        Container(
                          height: 21,
                          margin: EdgeInsets.only(left: 14, top: 24, right: 11),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: AutoSizeText(
                                  "${widget.projectData.location} ",
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 2, 2, 2),
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _launchURL();
                                },
                                child: Text("Map  >",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 2, 2, 2),
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    )),
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
            Column(
              children: [
                Container(
                    width: 200,
                    child: Text("In partnership with: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ))),
                Container(
                  child: Image.network(widget.projectData.sponsorlogo,
                      width: 200, fit: BoxFit.fill),
                ),
              ],
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: LinearPercentIndicator(
                percent: widget.projectData.percent.toDouble() / 100,
                lineHeight: 20,
                center: AutoSizeText(
                  "${widget.projectData.percent}% Funded",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color.fromARGB(255, 2, 2, 2),
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 17, top: 8, right: 8),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 216, 216, 216),
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                child: Scrollbar(
                    thickness: 5,
                    child: SingleChildScrollView(
                      child: Html(
                        data: projectData.description,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
