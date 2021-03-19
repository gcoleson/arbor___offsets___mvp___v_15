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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'subscriptionItem.dart';
import 'package:flutter/cupertino.dart';

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
  Future<List<SubscriptionItem>> subscriptionListGet = subLoad();
  var isExpandedTest = [false, false, false, false];
  int _selectedIndex = 0;
  List<SubscriptionItem> records = [];
  List<_SubscriptionTile> tiles = [];
  bool hasSubscriptions = true;

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
              AutoSizeText(
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
                width: 165,
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
        if (index == 1 && !isExpanded) {
          subLoad();
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
          body: Column(
            children: [
              FutureBuilder<List<SubscriptionItem>>(
                future: subscriptionListGet,
                builder: (BuildContext context,
                    AsyncSnapshot<List<SubscriptionItem>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    hasSubscriptions = false;
                    return Container(
                      child: Text(
                        "Loading...",
                      ),
                    );
                  } else if (snapshot.data.length <= 0) {
                    hasSubscriptions = false;

                    print('Here 4');

                    return Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 344,
                              height: 71,
                              child: Text(
                                "You have no upcoming payments",
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
                            "To activate one, start a purchase on your Dashboard and select “chase Monthly” on your Shopping Cart screen.",
                            textAlign: TextAlign.center,
                            style: AppFonts.smallIncidentals,
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  } else {
                    hasSubscriptions = true;
                    records.clear();
                    records.addAll(snapshot.data);
                    records.forEach((element) {
                      print('element');
                      print(element.projectName);
                    });
                    print('Here');
                    // set default selection
                    records[_selectedIndex].isSelected = false;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print('Here 1');
                        _SubscriptionTile tile =
                            _SubscriptionTile(records[index], () {});
                        print('record:${records[index].projectName}');
                        return tile;
                        /* InkWell(
                          child: tile,
                          onTap: () {
                            _selectedIndex = index;
                            print('tap');
                            print('index:$index');
                            print(
                                'selected index:${records[index].isSelected}');
                            /* setState(() {
                              //records.forEach((element) {
                              //  element.isSelected = false;
                              //});
                              records[index].isSelected = true;
                              print(
                                  'selected index:${records[index].isSelected}');
                            }) 
                            ;*/
                          },
                        ); */
                      },
                    );
                  }
                },
              ),
              cancelButton(),
            ],
          ),
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

  Future cancelDialogue() async {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text("Cancel Recurring Purchase"),
        content:
            new Text("Are you sure you want to stop supporting this project?"),
        actions: [
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () async {
              onCheckoutLoading(context);
              await cancelSelectedSub();
              print('cancelSelectedSub return');
              subscriptionListGet = subLoad();

              Navigator.pop(context);
              setState(() {
                if (records.isEmpty) {
                  _selectedIndex = 0;
                  hasSubscriptions = false;
                  print("records empty");
                }
              });
              Navigator.pop(context);
              cancelSuccessDialogue();
            },
          ),
        ],
      ),
    );
  }

  Future cancelSuccessDialogue() async {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: new Text("Your subscription has been successfully cancelled"),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<http.Response> cancelSelectedSub() async {
    // ping firebase to get the list of subscription
    http.Response response;

    for (int i = 0; i < records.length; i++) {
      if (records[i].isSelected) {
        print('waiting subscription:${records[i].subscriptionId} canceled');
        response = await http.post(
          'https://us-central1-financeapp-2c7b8.cloudfunctions.net/cancelSubscription',
          body: json.encode(
            {'cancelledSubId': records[i].subscriptionId},
          ),
        );
        print('waiting for done');
        print('status:${response.statusCode}');
        if (response.body != null && response.body != 'error') {
          print('subscription:${records[i].subscriptionId} canceled');
          records[i].isSelected = false;
        }
      }
    }

    print('Here 12');

    return response;
  }

  Widget cancelButton() {
    if (hasSubscriptions) {
      return ButtonTheme(
        minWidth: 344,
        height: 50,
        child: RaisedButton(
          color: Colors.red,
          key: null,
          onPressed: cancelDialogue,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          child: Text(
            "Cancel Selected",
            style: AppFonts.body2Bold2Dark1LabelColor2CenterAligned,
          ),
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}

// TODO: Add upcoming payment handling here
Widget buildManageUpcomingPayments(
    BuildContext context, Future<List<SubscriptionItem>> subscriptionList) {
  int _selectedIndex = 0;

  /*
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
    Divider(S
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
  */
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

Future<List<SubscriptionItem>> subLoad() async {
  // this is the item that we want to return
  List<SubscriptionItem> subscriptionList = [];

  // get reference of the user
  DocumentSnapshot ds = await databaseReference
      .collection('users')
      .doc(databaseService.uid)
      .get();

  // check to make sure that the user is a customer that has done business with us
  bool isCustomer = ds.data().containsKey("customerId");
  String customerId;

  // if the user is a customer then grab the customer Id
  if (isCustomer) {
    customerId = ds.get('customerId');
    print(customerId);
  } else {
    return subscriptionList;
  }

  // ping firebase to get the list of subscription
  http.Response response;
  response = await http.post(
    'https://us-central1-financeapp-2c7b8.cloudfunctions.net/getSubscriptionList',
    body: json.encode(
      {'customerIdClient': customerId},
    ),
  );

  // get list of all the subscriptions
  List<dynamic> subscriptionInfo = jsonDecode(response.body)['data'];

  // Loop through all the subscription items and grab the necessary info
  subscriptionInfo.forEach((element) {
    double amountDue = 0;
    // grab the necessary data for each list
    String projectTitle = element['metadata']['projectTitle'];
    String subscriptionId = element['id'];
    DateTime nextBillingDate = DateTime.fromMillisecondsSinceEpoch(
        element['current_period_end'] * 1000);

    List<dynamic> itemList = element["items"]["data"];

    itemList.forEach((element) {
      amountDue += element["price"]["unit_amount"];
    });
    amountDue /= 100;
    print("amount due is = " + amountDue.toString());
    print(subscriptionId);

    //Add to list of projects user is subscribed to
    subscriptionList.add(SubscriptionItem(
        projectTitle, subscriptionId, nextBillingDate, false, amountDue));
  });
  return subscriptionList;
}

class _SubscriptionTile extends StatefulWidget {
  final SubscriptionItem _item;

  final VoidCallback onSelect;
  _SubscriptionTile(this._item, this.onSelect);

  @override
  __SubscriptionTileState createState() => __SubscriptionTileState();
}

class __SubscriptionTileState extends State<_SubscriptionTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('tap 1');
          print(widget._item.isSelected);
          print(widget._item.projectName);
          setState(() {
            if (widget._item.isSelected == true)
              widget._item.isSelected = false;
            else
              widget._item.isSelected = true;
          });
        },
        child: Row(
          children: [
            Expanded(
              flex: 86,
              child: Column(
                children: [
                  widget._item.isSelected
                      ? Image.asset(
                          "assets/images/cancel-sub-icon.png",
                          height: 29,
                          width: 27,
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  Container(
                    height: 40,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 308,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    width: 308,
                    height: 30,
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget._item.projectName,
                      style: TextStyle(
                        fontFamily: 'Raleway-Light',
                        color:
                            widget._item.isSelected ? Colors.red : Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      ),
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
                      // '18.50	renewing ' + nextBillingCycleStart.toString(),
                      "\$" +
                          widget._item.amountDue.toString() +
                          "    renewing " +
                          widget._item.nextBillingDate.month.toString() +
                          "/" +
                          widget._item.nextBillingDate.day.toString() +
                          "/" +
                          widget._item.nextBillingDate.year.toString(),
                      style: TextStyle(
                        fontFamily: 'Raleway-LightItalic',
                        color:
                            widget._item.isSelected ? Colors.red : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
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
                ],
              ),
            ),
            Spacer(
              flex: 20,
            )
          ],
        ));
  }
}

void onCheckoutLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              CircularProgressIndicator(),
              Spacer(),
              Text(
                "Loading",
                style: AppFonts.arborSubTitle,
              ),
              Spacer(),
            ],
          ),
        ),
      );
    },
  );
}
