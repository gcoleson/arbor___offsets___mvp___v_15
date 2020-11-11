/*
*  dashboard_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/stripe/one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartItem {
  String header;
  String description;
  String imageText;
  String imageIcon;
  String documentID;
  double price;
  double coinCount;
  double treeCount;
  bool boxSelected;

  CartItem({
    this.header,
    this.description,
    this.imageText,
    this.imageIcon,
    this.boxSelected,
  });
}

List<CartItem> purchaseItemListItems = List<CartItem>();

Widget loadUserData(BuildContext context) {
  if (userdata.dataLoadedFromDB) {
    return Text(userdata.firstName + ' ' + userdata.lastName,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromARGB(255, 2, 2, 2),
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700,
          fontSize: 21,
        ));
  } else
    return new StreamBuilder(
        stream: databaseService.getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading User Data",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 2, 2),
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ));
          }
          var userDocument = snapshot.data;

          try {
            userdata.firstName = userDocument['firstname'];
            userdata.lastName = userDocument['lastname'];
            userdata.timestamp = userDocument['timestamp'];
            userdata.dataLoadedFromDB = true;
          } catch (error) {
            print('Get user data error');
            print(error.toString());
            return Text(userdata.firstName + ' ' + userdata.lastName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 2, 2),
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ));
          }

          return Text(userdata.firstName + ' ' + userdata.lastName,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700,
                fontSize: 21,
              ));
        });
}

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  void onItemPressed(BuildContext context) {}

  Color getBorderSelectColor(int index) {
    if (purchaseItemListItems[index].boxSelected == false) {
      //turn border on
      return Color.fromARGB(255, 0, 0, 0);
    } else {
      //turn border off
      return Color.fromARGB(255, 250, 195, 21);
    }
  }

  void toggleItemSelected(int index) {
    if (purchaseItemListItems[index].boxSelected == false) {
      //turn border on
      purchaseItemListItems[index].boxSelected = true;
    } else {
      //turn border off
      purchaseItemListItems[index].boxSelected = false;
    }
  }

  Widget generalButtonItemWidget(int index, String iconName, String iconText) {
    return GestureDetector(
        onTap: () {
          setState(() {
            toggleItemSelected(index);
          });
        },
        child: generalButtonItemContainer(index, iconName, iconText));
  }

  Widget buildHighlightedCartItems()
  //loop through all items and make into a grid 2x
  {
    List<Widget> returnList = new List();

    for (var i = 0; i < purchaseItemListItems.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (purchaseItemListItems[i].boxSelected == true) {
        returnList.add(generalButtonItemContainer(
            0,
            purchaseItemListItems[i].imageIcon,
            purchaseItemListItems[i].imageText));
      }
    }

    if (returnList.length == 0)
      return Spacer();
    else
      return Container(
          height: 400,
          width: 200,
          child: GridView.count(
            crossAxisCount: 2,
            children: returnList,
          ));
  }

  Color blueHighlight = Color.fromARGB(255, 18, 115, 211);
  var primaryAccentGreen = Color.fromARGB(255, 65, 127, 69);
  var iOsSystemBackgroundsLightSystemBack2 = Color.fromARGB(255, 255, 255, 255);

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                formCongrats(),
              ],
            ),
          );
        });
  }

  Container formCongrats() {
    return Container(
        width: 381,
        height: 700,
        decoration: new BoxDecoration(
            color: blueHighlight, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            new Text("Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xfffafcfd),
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                )),
            new Text(
                "By eliminating your climate impact, you’re helping reversing climate change!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Color(0xff010101),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                )),
            new Text("You just eliminated the climate impact of:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: iOsSystemBackgroundsLightSystemBack2,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                )),
            buildHighlightedCartItems(),
            new Text("Tell your friends how you’re going climate positive:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Color(0xff010101),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                )),
            new Container(
              width: 344,
              height: 50,
              decoration: new BoxDecoration(
                  color: primaryAccentGreen,
                  borderRadius: BorderRadius.circular(8)),
              child: new Text("Share",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    color: iOsSystemBackgroundsLightSystemBack2,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.408,
                  )),
            )
          ],
        ));
  }

  Future paymentSuccessBuildDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          insetPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Stack(
            overflow: Overflow.visible,
            fit: StackFit.expand,
            children: [
              //Text("data")
              successDialogue(),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  color: Color.fromARGB(0, 0, 0, 0),
                  height: 40,
                  width: 40,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.transparent,
                    child: Text(
                      "X",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container successDialogue() {
    return Container(
      alignment: Alignment.topCenter,
      //margin: EdgeInsetsGeometry.infinity,
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints.expand(),

      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage("assets/images/sunrise.png"),
            ),
          ),
          Spacer(),
          Text(
            "Congratulations!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(
            "By eliminiating your climate impact, you're helping reversing climate change!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(
            "Tell your freinds how you're going climate positive:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          _customButton("Share", () {}),
          Spacer(),
        ],
      ),

      decoration: BoxDecoration(
        color: Color.fromARGB(255, 28, 151, 211),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      // child: Stack(
      //   fit: StackFit.loose,
      //   children: [
      //     Image.asset("assets/images/WelcomeBackScreen.png"),
      //   ],
      // ),
    );
  }

  //TODO: Make the screens dynamic and not overflow for all typoes of screen resolutions
  Future checkoutCartBuildDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          insetPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Stack(
            overflow: Overflow.visible,
            fit: StackFit.expand,
            children: [
              //Text("data")
              checkoutCartDialogue(),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  color: Color.fromARGB(0, 0, 0, 0),
                  height: 40,
                  width: 40,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.transparent,
                    child: Text(
                      "X",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container buildLineItems()
  //loop through all items and make into a grid 2x
  {
    SingleChildScrollView productColumn;
    List<Widget> returnList = new List();
    double totalCost = 0;
    double totalTrees = 0;
    double totalCoins = 0;

    for (var i = 0; i < purchaseItemListItems.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (purchaseItemListItems[i].boxSelected == true) {
        totalCost += purchaseItemListItems[i].price;
        totalTrees += purchaseItemListItems[i].treeCount;
        totalCoins += purchaseItemListItems[i].coinCount;
        returnList.add(
          Row(
            children: [
              Spacer(
                flex: 50,
              ),
              Container(
                width: 200,
                child: Text(
                  purchaseItemListItems[i].imageText,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Raleway",
                  ),
                ),
              ),
              Container(
                width: 50,
                child: Text(
                  "\$" +
                      purchaseItemListItems[i]
                          .price
                          .toString()
                          .padRight(4, '0'),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Raleway",
                  ),
                ),
              ),
              Spacer(
                flex: 50,
              ),
            ],
          ),
        );
      }
    }

    returnList.add(
      Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
            width: 200,
            child: Text(
              "Total:",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            width: 80,
            child: Text(
              "\$" + totalCost.toStringAsFixed(2).padRight(4, '0'),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );

    returnList.add(
      Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
            width: 200,
            child: Text(
              "You'll Earn",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Raleway",
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );

    returnList.add(
      Row(
        children: [
          Spacer(
            flex: 50,
          ),
          Container(
            width: 200,
            child: Text(
              "Arbor Trees",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Raleway",
              ),
            ),
          ),
          Container(
            width: 50,
            child: Text(
              totalTrees.toString().padRight(4, '0'),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Raleway",
              ),
            ),
          ),
          Spacer(
            flex: 50,
          ),
        ],
      ),
    );

    returnList.add(
      Row(
        children: [
          Spacer(
            flex: 50,
          ),
          Container(
            width: 200,
            child: Text(
              "Arbor Coins",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Raleway",
              ),
            ),
          ),
          Container(
            width: 50,
            child: Text(
              totalCoins.toInt().toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Raleway",
              ),
            ),
          ),
          Spacer(
            flex: 50,
          ),
        ],
      ),
    );

    //returnList.add(value);

    return Container(
      width: 300,
      height: 140,
      child: SingleChildScrollView(
        child: Column(
          children: returnList,
        ),
      ),
    );
  }

  Container checkoutCartDialogue() {
    return Container(
      alignment: Alignment.topCenter,
      //margin: EdgeInsetsGeometry.infinity,
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints.expand(),

      child: Column(
        children: [
          Text(
            "Shopping Cart:",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w800),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage("assets/images/greg.PNG"),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Your Project:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Amazonian Valparaiso",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontFamily: "Raleway",
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(9, 0, 9, 0),
            child: Text(
              "Erase these actions by funding your project",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: "Raleway",
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          buildLineItems(),
          Text(
            "Eliminate your carbon Impact now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 28,
            ),
          ),
          Spacer(),
          _customButton(
            "Checkout",
            () async {
              Navigator.of(context).pop();

              String sessionId = 'error';
              //final sessionId = await Server().createCheckout();
              print(purchaseItemListItems[0].documentID);
              print(purchaseItemListItems[0].imageText);

              String checkout_json;
              var checkout_list = [];

              for (var i = 0; i < purchaseItemListItems.length; i++) {
                //check to see that headers don't match, if so make another area in the cart
                //always do the first one
                if (purchaseItemListItems[i].boxSelected == true) {
                  checkout_list.add(
                    {
                      'docID': purchaseItemListItems[i].documentID,
                      'quantity': 1
                    },
                  );
                }
              }

              // First Ping Firebase for session ID for stripe checkout
              final http.Response response = await http.post(
                'https://us-central1-financeapp-2c7b8.cloudfunctions.net/payment/',
                body: json.encode(
                  {'items': checkout_list},
                ),
              );

              print(jsonDecode(response.body));

              //then decode the json returned
              if (response.body != null && response.body != 'error') {
                sessionId = jsonDecode(response.body)['id'];
                print('Checkout Success!!!!');
              }

              if (sessionId != 'error') {
                // Call the one time checkout screen with session ID
                final outcome =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => OneTimeCheckout(
                              sessionId: sessionId,
                            )));
                if (outcome == "success") {
                  print("finished payment eeeee");
                  paymentSuccessBuildDialogue(context);
                } else if (outcome == "failure") {
                  print("Payment was a failure");
                  paymentFailureBuildDialogue(context);
                }
                final snackBar =
                    SnackBar(content: Text('SessionId: $sessionId'));
                //Scaffold.of(context).showSnackBar(snackBar);
                //_congratulationsDialogue();
              } else {
                print('Checkout Entry has failed');
              }
            },
          ),
          Spacer(),
        ],
      ),

      decoration: BoxDecoration(
        color: Color.fromARGB(255, 28, 151, 211),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      // child: Stack(
      //   fit: StackFit.loose,
      //   children: [
      //     Image.asset("assets/images/WelcomeBackScreen.png"),
      //   ],
      // ),
    );
  }

  Future paymentFailureBuildDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          insetPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Stack(
            overflow: Overflow.visible,
            fit: StackFit.expand,
            children: [
              //Text("data")
              failureDialogue(),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  color: Color.fromARGB(0, 0, 0, 0),
                  height: 40,
                  width: 40,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.transparent,
                    child: Text(
                      "X",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container failureDialogue() {
    return Container(
      alignment: Alignment.topCenter,
      //margin: EdgeInsetsGeometry.infinity,
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints.expand(),

      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage("assets/images/PaymentFailureDog.png"),
            ),
          ),
          Spacer(),
          Text(
            "Something go wrong?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(
            "You're seconds away from erasing your climate impact.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(
            "Tap below to go back to your shopping cart and check out again",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          _customButton(
            "Try Again",
            () => Navigator.of(context).pop(),
          ),
          Spacer(),
        ],
      ),

      decoration: BoxDecoration(
        color: Color.fromARGB(255, 28, 151, 211),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }

  Container generalButtonItemContainer(
      int index, String iconName, String iconText) {
    return Container(
      width: 95,
      height: 107,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 95,
              height: 107,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                border: Border.all(
                  width: 3,
                  color: getBorderSelectColor(index),
                ),
              ),
              child: Container(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.network(iconName, fit: BoxFit.fill),
                    onPressed: () {},
                  )),
              Text(iconText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 127, 69),
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Arbor",
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              loadUserData(context),
              buildImpactContainer(),
              buildMonthsInARowContainer(),
              buildTotalMonthsContainer(),
              buildLiveClimatePositveAlign(),
              buildOffsetPurchaseListContainer(context),
              buildCheckoutButtonContainer(),
            ],
          )
        ],
      ),
    );
  }

  Container buildCheckoutButtonContainer() {
    return Container(
      width: 300,
      height: 50,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: Radii.k8pxRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () /*async*/ {
                  checkoutCartBuildDialogue(context);
                  /*
                  String sessionId = 'error';
                  //final sessionId = await Server().createCheckout();
                  print(purchaseItemListItems[0].documentID);
                  print(purchaseItemListItems[0].imageText);

                  String checkout_json;
                  var checkout_list = [];

                  for (var i = 0; i < purchaseItemListItems.length; i++) {
                    //check to see that headers don't match, if so make another area in the cart
                    //always do the first one
                    if (purchaseItemListItems[i].boxSelected == true) {
                      checkout_list.add(
                        {
                          'docID': purchaseItemListItems[i].documentID,
                          'quantity': 1
                        },
                      );
                    }
                  }

                  // First Ping Firebase for session ID for stripe checkout
                  final http.Response response = await http.post(
                    'https://us-central1-financeapp-2c7b8.cloudfunctions.net/payment/',
                    body: json.encode(
                      {'items': checkout_list},
                    ),
                  );

                  print(jsonDecode(response.body));

                  //then decode the json returned
                  if (response.body != null && response.body != 'error') {
                    sessionId = jsonDecode(response.body)['id'];
                    print('Checkout Success!!!!');
                  }

                  if (sessionId != 'error') {
                    // Call the one time checkout screen with session ID
                    final outcome =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => OneTimeCheckout(
                                  sessionId: sessionId,
                                )));
                    if (outcome == "success") {
                      print("finished payment eeeee");
                      paymentSuccessBuildDialogue(context);
                      
                    } else if (outcome == "failure") {
                      print("Payment was a failure");
                      paymentFailureBuildDialogue(context);
                    }
                    final snackBar =
                        SnackBar(content: Text('SessionId: $sessionId'));
                    //Scaffold.of(context).showSnackBar(snackBar);
                    //_congratulationsDialogue();
                  } else {
                    print('Checkout Entry has failed');
                  }*/
                },
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "Checkout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      letterSpacing: -0.408,
                      height: 1.29412,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Container buildGeneralAreaContainer({
    @required String header,
    @required String description,
    @required IndexedWidgetBuilder itemBuilder,
  }) {
    return Container(
      width: 416,
      height: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 4),
            child: Text(
              header,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontFamily: "Raleway",
                fontWeight: FontWeight.w300,
                fontSize: 21,
              ),
            ),
          ),
          Container(
            width: 382,
            margin: EdgeInsets.only(left: 4, top: 2),
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontFamily: "Raleway",
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: 383,
            height: 108,
            margin: EdgeInsets.only(left: 14, top: 9),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 108,
                childAspectRatio: 1.13684,
                mainAxisSpacing: 30,
              ),
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOffsetPurchaseListContainer(BuildContext context) {
    return Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Container(
            height: 600,
            margin: EdgeInsets.only(left: 1, top: 16, right: 5),
            child: buildProductsListWidget(context),
          ),
        ));
  }

  Widget buildGeneralButtonItemWidget(BuildContext context, int index,
      int startIndex, List<CartItem> cartList, String header) {
    //keep returning widgets until the headers don't match

    if (((startIndex + index) < cartList.length) &&
        (cartList[startIndex + index].header == header))
      return generalButtonItemWidget(
          startIndex + index,
          cartList[startIndex + index].imageIcon,
          cartList[startIndex + index].imageText);
    else
      return null;
  }

  Widget buildProductsListWidget(BuildContext context) {
    try {
      if (purchaseItemList().isNotEmpty) {
        print('not empty purchase list');
        return Column(
          children: purchaseItemList(),
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      } else {
        print('empty purchase list');
        return StreamBuilder<QuerySnapshot>(
          stream: databaseReference.collection("products").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            final int messageCount = snapshot.data.docs.length;

            for (var i = 0; i < messageCount; i++) {
              //loop through all records
              DocumentSnapshot document = snapshot.data.docs[i];

              CartItem item = new CartItem();

              item.description = document['description'];
              item.header = document['header'];
              item.imageText = document['imagetext'];
              item.imageIcon = document['imageicon'];
              item.documentID = document.id;
              item.price = document['price'];
              item.treeCount = double.parse(document['treecount'].toString());
              print(document['coincount']);

              item.coinCount = 5.0;
              item.boxSelected = false;

              purchaseItemListItems.add(item);
            }
            return Column(
              children: purchaseItemList(),
              crossAxisAlignment: CrossAxisAlignment.start,
            );
          },
        );
      }
    } catch (error) {
      print('product db error');
      print(error.toString());
      return Container();
    }
  }

  List<Widget> purchaseItemList() {
    List<Widget> returnList = new List();
    Widget tempWidget;

    //sort the list
    purchaseItemListItems.sort((a, b) => a.header.compareTo(b.header));

    for (var i = 0; i < purchaseItemListItems.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (i == 0 ||
          (purchaseItemListItems[i].header !=
              purchaseItemListItems[i - 1].header)) {
        tempWidget = (buildGeneralAreaContainer(
            header: purchaseItemListItems[i].header,
            description: purchaseItemListItems[i].description,
            itemBuilder: (context, index) => buildGeneralButtonItemWidget(
                context,
                index,
                i,
                purchaseItemListItems,
                purchaseItemListItems[i].header)));

        returnList.add(tempWidget);
      }
    }

    return returnList;
  }

  Align buildLiveClimatePositveAlign() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(left: 5, top: 31),
        child: Text(
          "Live Climate Positive: ",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 65, 127, 69),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  Container buildTotalMonthsContainer() {
    return Container(
      height: 57,
      margin: EdgeInsets.only(right: 1),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: 8,
            right: 0,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 93, 187, 71),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(128, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(),
            ),
          ),
          Positioned(
            left: 24,
            top: 8,
            right: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "5",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 195, 21),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      "total months of impact",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildMonthsInARowContainer() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 1, top: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: -0,
            right: 0,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 93, 187, 71),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 151, 151, 151),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(128, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(),
            ),
          ),
          Positioned(
            left: 22,
            top: -1,
            right: 11,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "2",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 195, 21),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      "months in a row of impact",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 2, 2),
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildImpactContainer() {
    return Container(
        //height: 400,
        margin: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              alignment: Alignment.topLeft,
              child: Text(
                "Your Impact:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 65, 127, 69),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ),
            Row(children: [
              Container(
                  height: 90,
                  width: 90,
                  margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                  child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(9, (index) {
                        return Center(
                          child: Image.asset(
                            "assets/images/icons8-oak-tree-100-2-copy-9.png",
                            //fit: BoxFit.,
                          ),
                        );
                      }))),
              Container(
                  height: 90,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: AutoSizeText(
                            "9 trees earned this month.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 250, 195, 21),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: AutoSizeText(
                              "38 all-time!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 250, 195, 21),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      ]))
            ])
          ],
        ));
  }
}

Row _customButton(String buttonText, Function onButtonPress) {
  return Row(
    children: [
      Spacer(flex: 21),
      Flexible(
        flex: 379,
        child: Container(
          height: 50,
          width: 379,
          child: RaisedButton(
            color: Color.fromARGB(255, 65, 127, 69),
            onPressed: onButtonPress,
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "SFProText-Semibold",
                  fontSize: 17),
            ),
          ),
        ),
      ),
      Spacer(flex: 14)
    ],
  );
}
