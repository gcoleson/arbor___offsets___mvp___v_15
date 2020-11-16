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
import 'CartItem.dart';
import 'shopping_cart_widget.dart';

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
                onTap: () {
                  checkoutCartBuildDialogue(context, purchaseItemListItems);
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
