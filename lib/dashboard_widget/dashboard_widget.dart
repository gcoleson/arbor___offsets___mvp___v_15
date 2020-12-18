/*
*  dashboard_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/onboarding_screens/onboarding_screen.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/stripe/one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import 'CartItem.dart';
import 'shopping_cart_widget.dart';
import 'UserStats.dart';
import 'user_stats_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/arbor_explanation.dart';

List<CartItem> purchaseItemListItems = List<CartItem>();
UserStats userStats = new UserStats();

Widget loadUserData(BuildContext context) {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final User user = auth.currentUser;

  //TODO: Name should be used instead, email address is used temporarily
  // if (user != null) {
  //   return Text(user.email,
  //       textAlign: TextAlign.left,
  //       style: TextStyle(
  //         color: Color.fromARGB(255, 2, 2, 2),
  //         fontFamily: "Raleway",
  //         fontWeight: FontWeight.w700,
  //         fontSize: 21,
  //       ));
  // }

  if (userdata.dataLoadedFromDB) {
    return SizedBox.shrink();
    // return Text(userdata.firstName + ' ' + userdata.lastName,
    //     textAlign: TextAlign.left,
    //     style: TextStyle(
    //       color: Color.fromARGB(255, 2, 2, 2),
    //       fontFamily: "Raleway",
    //       fontWeight: FontWeight.w700,
    //       fontSize: 21,
    //     ));
  } else
    return new StreamBuilder(
      stream: databaseService.getUserData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
          // return Text("Loading User Data",
          //     textAlign: TextAlign.left,
          //     style: TextStyle(
          //       color: Color.fromARGB(255, 2, 2, 2),
          //       fontFamily: "Raleway",
          //       fontWeight: FontWeight.w700,
          //       fontSize: 21,
          //     ));
        }
        var userDocument = snapshot.data;

        try {
          userdata.firstName = userDocument['firstname'];
          userdata.lastName = userDocument['lastname'];
          userdata.createtimestamp = userDocument['createtimestamp'];
          userdata.selectedprojectnumber =
              userDocument['selectedprojectnumber'];
          userdata.dataLoadedFromDB = true;
          return SizedBox.shrink();
        } catch (error) {
          print('Get user data error');
          print(error.toString());
          return SizedBox.shrink();
          // return Text(userdata.firstName + ' ' + userdata.lastName,
          //     textAlign: TextAlign.left,
          //     style: TextStyle(
          //       color: Color.fromARGB(255, 2, 2, 2),
          //       fontFamily: "Raleway",
          //       fontWeight: FontWeight.w700,
          //       fontSize: 21,
          //     ));
        }

        // return Text(
        //   userdata.firstName + ' ' + userdata.lastName,
        //   textAlign: TextAlign.left,
        //   style: TextStyle(
        //     color: Color.fromARGB(255, 2, 2, 2),
        //     fontFamily: "Raleway",
        //     fontWeight: FontWeight.w700,
        //     fontSize: 21,
        //   ),
        // );
      },
    );
}

class DashboardWidget extends StatefulWidget {
  final VoidCallback onUserIconPressed;

  DashboardWidget(this.onUserIconPressed);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  void onItemPressed(BuildContext context) {}

  //TODO: Make the screens dynamic and not overflow for all typoes of screen resolutions
  Future checkoutCartBuildDialogue(
      BuildContext context, List<CartItem> purchaseItemList) {
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
              checkoutCartDialogue(context, purchaseItemList),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  color: Color.fromARGB(0, 0, 0, 0),
                  height: 40,
                  width: 40,
                  child: FlatButton(
                    onPressed: () {
                      clearCheckoutHighlights();
                      Navigator.of(context).pop();
                    },
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

  Color getProductBorderSelectColor(int index) {
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

      analytics.logEvent(name: 'add_to_cart', parameters: {
        'imageText': purchaseItemListItems[index].imageText,
        'header': purchaseItemListItems[index].header,
        'price': purchaseItemListItems[index].price,
        'coincount': purchaseItemListItems[index].coinCount,
      });
    } else {
      //turn border off
      purchaseItemListItems[index].boxSelected = false;
      analytics.logEvent(name: 'remove_from_cart', parameters: {
        'imageText': purchaseItemListItems[index].imageText,
        'header': purchaseItemListItems[index].header,
        'price': purchaseItemListItems[index].price,
        'coincount': purchaseItemListItems[index].coinCount,
      });
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

  void clearCheckoutHighlights() {
    setState(() {
      for (var i = 0; i < purchaseItemListItems.length; i++) {
        purchaseItemListItems[i].boxSelected = false;
      }
    });
  }

  Widget buildHighlightedCartItems()
  //loop through all items and make into a grid 2x
  {
    List<Widget> returnList = new List();

    for (var i = 0; i < purchaseItemListItems.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (purchaseItemListItems[i].boxSelected == true) {
        returnList.add(
          generalButtonItemContainer(0, purchaseItemListItems[i].imageIcon,
              purchaseItemListItems[i].imageText),
        );
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
        ),
      );
  }

  Color blueHighlight = Color.fromARGB(255, 18, 115, 211);
  var primaryAccentGreen = Color.fromARGB(255, 65, 127, 69);
  var iOsSystemBackgroundsLightSystemBack2 = Color.fromARGB(255, 255, 255, 255);

  /*===============================================================================================
  Deprecated: old dialogue builder for the congrtulations dialogue box
  ================================================================================================*/
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

  /*===============================================================================================
  Deprecated: original dialogue box for congratulation of payment
  ================================================================================================*/
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

  /*===============================================================================================
  Container for squares that contain product
  ================================================================================================*/
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
                  color: getProductBorderSelectColor(index),
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
                    onPressed: () {
                      //todo remove hack to get the icon to be clickable
                      //whole button should be clickable
                      setState(() {
                        toggleItemSelected(index);
                      });
                    },
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

  /*===============================================================================================
  Building Widget
  ================================================================================================*/
  @override
  void initState() {
    super.initState();
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
    // user statistics
    analytics.logEvent(name: 'DashboardScreen');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Arbor",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Montserrat Semi-Bold",
            fontWeight: FontWeight.w600,
            fontSize: 36,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: this
                .widget
                .onUserIconPressed, // this is a void callback to tab group one tab bar
            icon: Image.asset(
              "assets/images/UserIcon.png",
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
              buildUserStats(context, userStats),
              buildLiveClimatePositveAlign(),
              buildOffsetPurchaseListContainer(context),
              buildCheckoutButtonContainer(),
              //add some space below the checkout button
              Container(
                height: 20,
              )
            ],
          )
        ],
      ),
    );
  }

  /*===============================================================================================
  Checkout Button
  ================================================================================================*/
  Widget buildCheckoutButtonContainer() {
    return GestureDetector(
        onTap: () {
          checkoutCartBuildDialogue(context, purchaseItemListItems);
        },
        child: Container(
          width: 300,
          height: 50,
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryDarkGreen,
            borderRadius: Radii.k8pxRadius,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "Checkout",
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
                  );
                },
              ),
            ],
          ),
        ));
  }

  /*===============================================================================================
  ???
  ================================================================================================*/
  Container buildGeneralAreaContainer({
    @required String header,
    @required String description,
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
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
              itemCount: itemCount,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 108,
                childAspectRatio: 1.13684,
                mainAxisSpacing: 18,
              ),
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  /*===============================================================================================
  ???
  ================================================================================================*/
  Widget buildOffsetPurchaseListContainer(BuildContext context) {
    return Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 1, top: 8, right: 5, bottom: 8),
            child: buildProductsListWidget(context),
          ),
        ));
  }

  /*===============================================================================================
  Building Squares for each item to purchase
  ================================================================================================*/
  Widget buildGeneralButtonItemWidget(BuildContext context, int index,
      int startIndex, List<CartItem> cartList, String header) {
    //keep returning widgets until the headers don't match

    if (((startIndex + index) < cartList.length) &&
        (cartList[startIndex + index].header == header)) {
      return generalButtonItemWidget(
          startIndex + index,
          cartList[startIndex + index].imageIcon,
          cartList[startIndex + index].imageText);
    } else
      return null;
  }

  /*===============================================================================================
  Count the Building Squares for each item to purchase
  ================================================================================================*/

  /*===============================================================================================
  Stream Builder for Products
  ================================================================================================*/
  Widget buildProductsListWidget(BuildContext context) {
    try {
      if (purchaseItemList().isNotEmpty) {
        print('PurchaseItemList not empty');
        return Column(
          children: purchaseItemList(),
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      } else {
        return StreamBuilder<QuerySnapshot>(
          stream: databaseReference
              .collection("products")
              .snapshots(includeMetadataChanges: true),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            /*print(snapshot.data.metadata.isFromCache
                ? "NOT FROM NETWORK"
                : "FROM NETWORK");*/

            final int productCount = snapshot.data.docs.length;

            for (var i = 0; i < productCount; i++) {
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
              item.coinCount = 5.0;
              item.boxSelected = false;

              //check to make sure we have not added this document yet
              if (purchaseItemListItems.isNotEmpty) {
                purchaseItemListItems.removeWhere(
                    (element) => element.documentID == item.documentID);
              }

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

  int itemCountInArea(int start, String header) {
    int i;
    purchaseItemListItems.sort((a, b) => a.header.compareTo(b.header));
    for (i = 0; start < purchaseItemListItems.length; i++, start++) {
      if (purchaseItemListItems[start].header != header) {
        break;
      }
    }
    return i;
  }

  /*===============================================================================================
  Calculating all the items needed to go into each row
  ================================================================================================*/
  List<Widget> purchaseItemList() {
    List<Widget> returnList = new List();
    Widget tempWidget;

    //sort the list
    purchaseItemListItems.sort((a, b) => a.price.compareTo(b.price));
    purchaseItemListItems.sort((a, b) => a.header.compareTo(b.header));

    for (var i = 0; i < purchaseItemListItems.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (i == 0 ||
          (purchaseItemListItems[i].header !=
              purchaseItemListItems[i - 1].header)) {
        tempWidget = (buildGeneralAreaContainer(
          itemCount: itemCountInArea(i, purchaseItemListItems[i].header),
          header: purchaseItemListItems[i].header,
          description: purchaseItemListItems[i].description,
          itemBuilder: (context, index) => buildGeneralButtonItemWidget(context,
              index, i, purchaseItemListItems, purchaseItemListItems[i].header),
        ));

        returnList.add(tempWidget);
      }
    }

    return returnList;
  }

  /*===============================================================================================
  Title above the product list
  ================================================================================================*/
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
}

Future<String> checkFirstTimeOpen() async {
  String value;
  try {
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data2.txt');
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
      title: new Text("Select an Activity"),
      content: new Text(
          "Pick an activity to reverse its climate impact. Arbor automatically calculates the cost of undoing its negative impact."),
      actions: [
        CupertinoDialogAction(
          child: Text("Got it"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text("Tell Me More"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => arborExplanation()));
          },
        ),
      ],
    ),
  );
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/data2.txt');
  await file.writeAsString(text);
}
