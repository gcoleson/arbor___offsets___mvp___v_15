/*
*  user_account_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:arbor___offsets___mvp___v_15/values/radii.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/arbor_explanation.dart';

import '../main.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'info@412technology.com',
    query: 'subject=Arbor app feedback'.replaceAll(" ", "%20"));

convertDate(int date) {
  var format = new DateFormat("yMd");
  var dateString = format.format(DateTime.fromMillisecondsSinceEpoch(date));
  return dateString;
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var isExpandedTest = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
            child: loadUserData(context),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 5, bottom: 10),
            child: Text(
              "Member since ${DateFormat('yMd').format(DateTime.fromMillisecondsSinceEpoch(userdata.createtimestamp, isUtc: true))}",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontFamily: "Raleway",
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 21,
              ),
            ),
          ),
          showProfilePanel(context),
        ],
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();

  Widget changeEmailOrPassword(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 216, 216, 216),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "New Email ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              Align(
                child: Container(
                  width: 200,
                  child: TextField(
                    controller: TextEditingController(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      icon: new Icon(Icons.mail, color: Colors.grey),
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Color.fromARGB(255, 98, 0, 238),
                      fontFamily: "HK Grotesk",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    autocorrect: false,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "New Password ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              Container(
                width: 200,
                child: TextField(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: new Icon(Icons.vpn_key, color: Colors.grey),
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color.fromARGB(255, 98, 0, 238),
                    fontFamily: "HK Grotesk",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  autocorrect: false,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Reenter New Password",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              Container(
                width: 200,
                child: TextField(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: new Icon(Icons.vpn_key, color: Colors.grey),
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color.fromARGB(255, 98, 0, 238),
                    fontFamily: "HK Grotesk",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  autocorrect: false,
                ),
              ),
            ],
          ),
          Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.primaryDarkGreen,
              borderRadius: Radii.k8pxRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "Sign Out",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        letterSpacing: -0.408,
                        height: 1.29412,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Version:' + packageInfo.version + '.' + packageInfo.buildNumber,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w400,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget showProfilePanel(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          isExpandedTest[index] = !isExpanded;
        });
        if (index == 3 && !isExpanded) {
          launch(emailLaunchUri.toString());
        }
        if (index == 2 && !isExpanded) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => arborExplanation()));
        }
      },
      expandedHeaderPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              color: AppColors.transparentScreen,
              child: ListTile(
                title: Text(
                  "Change Email or Password",
                  textAlign: TextAlign.left,
                  style: AppFonts.screenSubhead,
                ),
              ),
            );
          },
          body: changeEmailOrPassword(context),
          isExpanded: isExpandedTest[0],
        ),

        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              color: AppColors.transparentScreen,
              child: ListTile(
                title: AutoSizeText(
                  "Manage Upcoming Payments",
                  textAlign: TextAlign.left,
                  style: AppFonts.screenSubhead,
                ),
              ),
            );
          },
          body: buildManageUpcomingPayments(),
          isExpanded: isExpandedTest[1],
        ),

        //TODO: Scope Reduction Revisit Later
        // ExpansionPanel(
        //   canTapOnHeader: true,
        //   headerBuilder: (BuildContext context, bool isExpanded) {
        //     return ListTile(
        //       title: Text(
        //         "Replay Tutorial",
        //         textAlign: TextAlign.left,
        //         style: TextStyle(
        //           color: Color.fromARGB(255, 65, 127, 69),
        //           fontFamily: "Montserrat",
        //           fontWeight: FontWeight.w500,
        //           fontSize: 28,
        //         ),
        //       ),
        //     );
        //   },
        //   body: Text("test 3"),
        //   isExpanded: isExpandedTest[2],
        // ),
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              color: AppColors.transparentScreen,
              child: ListTile(
                title: Text(
                  "How Arbor Works",
                  textAlign: TextAlign.left,
                  style: AppFonts.screenSubhead,
                ),
              ),
            );
          },
          body: Text("test"),
          //isExpanded: isExpandedTest[1]
        ),

        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              color: AppColors.transparentScreen,
              child: ListTile(
                title: Text(
                  "Contact Us",
                  textAlign: TextAlign.left,
                  style: AppFonts.screenSubhead,
                ),
              ),
            );
          },
          body: Text("test"),
          //isExpanded: isExpandedTest[1]
        ),
      ],
    );
  }
}

// TODO: Add upcoming payment handling here
Widget buildManageUpcomingPayments() {
  return Column(children: [
    SizedBox(height: 15),
    Container(
      width: 308,
      height: 30,
      alignment: Alignment.topLeft,
      child: Text(
        'Bundle: Conservation Projects',
        style: AppFonts.projectLabelHeadline,
      ),
    ),
    SizedBox(
      height: 1,
    ),
    Container(
      width: 308,
      height: 30,
      alignment: Alignment.topLeft,
      child: Text(
        '18.50	renewing 3/12/21',
        style: AppFonts.projectLabelSubhead,
      ),
    ),
    SizedBox(
      height: 1,
    ),
    Container(
      width: 308,
      height: 16,
      alignment: Alignment.topLeft,
      child: Text(
        'Active',
        style: AppFonts.activeSubscriptionLabel,
      ),
    ),
    Divider(
      height: 32,
      thickness: 2,
      color: AppColors.divider,
      indent: 63,
      endIndent: 20,
    ),
    Container(
      width: 308,
      height: 30,
      alignment: Alignment.topLeft,
      child: Text(
        'Bundle: Conservation Projects',
        style: AppFonts.projectLabelHeadline,
      ),
    ),
    SizedBox(
      height: 1,
    ),
    Container(
      width: 308,
      height: 30,
      alignment: Alignment.topLeft,
      child: Text(
        '18.50	renewing 3/12/21',
        style: AppFonts.projectLabelSubhead,
      ),
    ),
    SizedBox(
      height: 1,
    ),
    Container(
      width: 308,
      height: 16,
      alignment: Alignment.topLeft,
      child: Text(
        'Active',
        style: AppFonts.activeSubscriptionLabel,
      ),
    ),
    SizedBox(height: 40),
    ButtonTheme(
        minWidth: 344,
        height: 50,
        child: RaisedButton(
            color: Colors.red,
            key: null,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            child: Text(
              "Manage Subscriptions",
              style: AppFonts.body2Bold2Dark1LabelColor2CenterAligned,
            ))),
    SizedBox(height: 10),
    ButtonTheme(
        minWidth: 344,
        height: 50,
        child: RaisedButton(
            color: Colors.red,
            key: null,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            child: Text(
              "Cancel Selected",
              style: AppFonts.body2Bold2Dark1LabelColor2CenterAligned,

//screen with no upcoming payments
              /*Column(
    children: [
      Column(
          children: [
            Container(
              width: 344,
              height: 71,
              child: Text(
                "You have no upcoming recurring monthly",
                textAlign: TextAlign.center,
                style: AppFonts.unactivatedItemTextCenter,
              ),
            ),
          ],
      ),
      SizedBox(height: 21),
      Container(
          width: 344,
          height: 35,
          child: Text(
            "To activate one, start a purchase on your Dashboard and select “Repeat This Purchase Monthly” on your shopping cart screen.",
            textAlign: TextAlign.center,
            style: AppFonts.smallIncidentals,
          ),
      )
    ],*/
            ))),
    SizedBox(height: 30),
  ]);
}

class UserAccountWidget extends StatelessWidget {
  void onChangeCopyPressed(BuildContext context) {}

  void onItemPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'UserAccountScreen');

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          "Profile",
          textAlign: TextAlign.center,
          style: AppFonts.navBarHeader,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 65, 127, 69),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: MyStatefulWidget(),
      ),
    );
  }
}
