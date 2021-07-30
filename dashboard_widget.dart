/*
*  dashboard_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

//import 'package:arbor___offsets___mvp___v_15/dashboard_widget/general_cart_item_widget.dart';
//import 'package:arbor___offsets___mvp___v_15/dashboard_widget/shopping_cart_widget.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String header;
  final String description;
  final String imageText;
  final String imageIcon;
  bool boxSelected;

  CartItem(
      {this.header,
      this.description,
      this.imageText,
      this.imageIcon,
      this.boxSelected});
}

List<CartItem> purchaseItemListTest = [
  CartItem(
      header: "Eliminate Fuel Impact:",
      description: "Remove climate impact from an average tank of gas for:",
      imageIcon: "assets/images/icons8-gas-station-100.png",
      imageText: 'Hybrid 0',
      boxSelected: false),
  CartItem(
      header: "Eliminate Fuel Impact:",
      description: "Remove climate impact from an average tank of gas for:",
      imageIcon: "assets/images/icons8-gas-station-100.png",
      imageText: 'Hybrid 1',
      boxSelected: false),
  CartItem(
      header: "Eliminate Fuel Impact:",
      description: "Remove climate impact from an average tank of gas for:",
      imageIcon: "assets/images/icons8-gas-station-100.png",
      imageText: 'Hybrid 2',
      boxSelected: false),
  CartItem(
      header: "Eliminate Travel Impact:",
      description: "Remove climate impact from an average flight between:",
      imageIcon: "assets/images/icons8-airplane-take-off-100-copy.png",
      imageText: 'New York & Chicago (2 hrs)',
      boxSelected: false),
  CartItem(
      header: "Eliminate Travel Impact:",
      description: "Remove climate impact from an average flight between:",
      imageIcon: "assets/images/icons8-airplane-take-off-100-copy.png",
      imageText: 'New York & Chicago (4 hrs)',
      boxSelected: false),
  CartItem(
      header: "Eliminate Travel Impact:",
      description: "Remove climate impact from an average flight between:",
      imageIcon: "assets/images/icons8-airplane-take-off-100-copy.png",
      imageText: 'New York & Chicago (6 hrs)',
      boxSelected: false),
  CartItem(
      header: "Eliminate Package Delivery:",
      description: "Remove climate impact from a typical shipment that is:",
      imageIcon: "assets/images/icons8-in-transit-100-copy-3.png",
      imageText: 'Small (under 5lbs)',
      boxSelected: false),
  CartItem(
      header: "Eliminate Package Delivery:",
      description: "Remove climate impact from a typical shipment that is:",
      imageIcon: "assets/images/icons8-in-transit-100-copy-3.png",
      imageText: 'Medium (under 5lbs)',
      boxSelected: false),
  CartItem(
      header: "Eliminate Package Delivery:",
      description: "Remove climate impact from a typical shipment that is:",
      imageIcon: "assets/images/icons8-in-transit-100-copy-3.png",
      imageText: 'Large (under 5lbs)',
      boxSelected: false),
];

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  void onItemPressed(BuildContext context) {}

  Color getBorderSelectColor(int index) {
    if (purchaseItemListTest[index].boxSelected == false) {
      //turn border on
      return Color.fromARGB(255, 0, 0, 0);
    }
    else {
      //turn border off
      return Color.fromARGB(255, 250, 195, 21);
    }
  }

  void toggleItemSelected(int index) {
    if (purchaseItemListTest[index].boxSelected == false) {
      //turn border on
      purchaseItemListTest[index].boxSelected = true;
    }
    else {
      //turn border off
      purchaseItemListTest[index].boxSelected = false;
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

    for (var i = 0; i < purchaseItemListTest.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (purchaseItemListTest[i].boxSelected == true) {
        returnList.add(generalButtonItemContainer(
            0,
            purchaseItemListTest[i].imageIcon,
            purchaseItemListTest[i].imageText));
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
    //return returnList[0];
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
                form(),
              ],
            ),
          );
        });
  }

//Form form() {
  Container form() {
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

    /*return Form(
    //key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text("Submitß"),
            onPressed: () {
              /*(if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }*/
            },
          ),
        )
      ],
    ),
  );*/
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
                    icon: Image.asset(iconName, fit: BoxFit.fill),
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
              buildImpactContainer(),
              buildMonthsInARowContainer(),
              buildTotalMonthsContainer(),
              buildLiveClimatePositveAlign(),
              buildOffsetPurchaseListContainer(),
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
          GestureDetector(
              onTap: () {
                buildShowDialog(context);
              },
              child: Container(
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
              )),
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

  Container buildOffsetPurchaseListContainer() {
    return Container(
      height: 601,
      margin: EdgeInsets.only(left: 1, top: 16, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: purchaseItemList(),

      ),

    );
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

  List<Widget> purchaseItemList() {
    List<Widget> returnList = new List();
    Widget tempWidget;

    for (var i = 0; i < purchaseItemListTest.length; i++) {
      //check to see that headers don't match, if so make another area in the cart
      //always do the first one
      if (i == 0 ||
          (purchaseItemListTest[i].header !=
              purchaseItemListTest[i - 1].header)) {
        tempWidget = (buildGeneralAreaContainer(
            header: purchaseItemListTest[i].header,
            description: purchaseItemListTest[i].description,
            itemBuilder: (context, index) => buildGeneralButtonItemWidget(
                context,
                index,
                i,
                purchaseItemListTest,
                purchaseItemListTest[i].header)));

        returnList.add(tempWidget);
      }
    }

    return returnList;
  }

  void purchasecleanup(purchaseItemList){
    for (var i = 0; i < purchaseItemList.length; i++){
      for (var j = 0; j < purchaseItemListTest.length; j++){
        if (purchaseItemList[i]==purchaseItemListTest[j]){
          purchaseItemListTest[j].boxSelected=false;
        }
      }
    }
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