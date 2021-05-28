// @dart=2.9

import 'dart:convert';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/shopping_cart_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'UserStats.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:http/http.dart' as http;

/*===============================================================================================
  Stream Builder for User Data
  ================================================================================================*/
StreamBuilder buildUserStats(BuildContext context, UserStats userStats) {
  return StreamBuilder(
    stream: databaseReference
        .collection("users")
        .doc(databaseService.uid)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return CircularProgressIndicator();
      }
      try {
        userStats.consecutiveMonths = snapshot.data["consecutiveMonths"];

        userStats.totalMonths = snapshot.data["totalMonths"];

        var dummy1;

        dummy1 = snapshot.data["totalTrees"];

        if (dummy1 is int) {
          userStats.totalTrees = dummy1;
        } else {
          userStats.totalTrees = dummy1.toInt();
        }

        var dummy2;
        dummy2 = snapshot.data["treesThisMonth"];

        if (dummy2 is int) {
          userStats.treesThisMonth = dummy2;
        } else {
          userStats.treesThisMonth = dummy2.toInt();
        }

        userStats.totalCoins =
            testDBForField(snapshot.data, "coinsCurrentAmount");

        if (userStats.totalCoins == null) userStats.totalCoins = 0;

        return Column(
          children: [
            buildImpactContainer(userStats),
            buildMonthsInARowContainer(userStats.consecutiveMonths),
            buildTotalMonthsContainer(userStats.totalMonths)
          ],
        );
      } catch (error) {
        print(error.toString());

        return Column(
          children: [
            buildImpactContainer(userStats),
            buildMonthsInARowContainer(0),
            buildTotalMonthsContainer(0)
          ],
        );
      }
    },
  );
}

/*===============================================================================================
  Container for squares that contain product
  ================================================================================================*/
Container cardItemContainer(
    BuildContext context, int index, String iconCloudPath) {
  return Container(
    width: 95,
    height: 139,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 95,
            height: 139,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 216, 216, 216),
              border: Border.all(
                width: 3,
                color: AppColors.Black,
              ),
            ),
            child: Container(),
          ),
        ),
        Container(
          width: 95,
          height: 139,
          child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Image.asset("assets/images/icons8Lock100Copy3.png"),
                //icon: Image.network(iconCloudPath, fit: BoxFit.fill),
                onPressed: () {
                  cardDetailDialogue(context, "assets/images/yellowstone.png",
                      "Description Text", "Fun Fact Text");
                },
              )),
        ),
      ],
    ),
  );
}

Future cardDetailDialogue(BuildContext context, String imagePath,
    String description, String funFact) {
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
          fit: StackFit.expand,
          children: [
            cardDialogue(imagePath, description, funFact),
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

Container cardDialogue(String imagePath, String description, String funFact) {
  return Container(
    padding: EdgeInsets.all(0),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          //child: Image.network(imagePath),
          child: Image.asset(imagePath),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8, 16, 16, 12),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: AppColors.primaryDarkGreen,
                fontFamily: "Railway",
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8, 16, 16, 12),
          child: Text(
            funFact,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xfff26a2c),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            "Tell your freinds how you're going climate positive:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        customButton("Share", () async {
          await Share.share(
              'I’m fighting climate change—sign up here to join me! https://getarborapp.com/',
              subject: 'Arbor');
        }),
      ],
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  );
}

List<dynamic> cardList = [];

getCardsHttp(String uid) {
  //don't get cards if we already have them
  if (cardList.length != 0) return;

  //response = await http.post(Uri.parse(
  Future<http.Response> response = http.post(Uri.parse(
          //'https://us-central1-financeapp-2c7b8.cloudfunctions.net/getCards'),
          'https://us-central1-financeapp-2c7b8.cloudfunctions.net/testCards'),
      body: json.encode(
        {
          'userId': uid,
        },
      ));

  response.then((value) {
    getCardsHttpResponse(value);
  });
}

getCardsHttpResponse(http.Response response) {
  print(jsonDecode(response.body));

  print("cardList 0");

  if (response.body != 'error') {
    print("cardList 1");
    cardList = jsonDecode(response.body)['cardList'];
    print(
        "list ${cardList.length}:${cardList[0]["cardIndex"]} ${cardList[0]["imageLink"]} ${cardList[0]["date"]} ${cardList[0]["extraInfo"]}");
    print("cardList 2");
  }
}

Container buildCardsContainer() {
  return Container(
    width: 416,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "<",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryDarkGreen,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              //margin: EdgeInsets.only(left: 20, right: 20),
              child: AutoSizeText(
                "This Month's Collection:",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryDarkGreen,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                ">",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryDarkGreen,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 382,
          margin: EdgeInsets.only(left: 4, top: 2),
          child: AutoSizeText(
            "National Parks",
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryDarkGreen,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 34,
            ),
          ),
        ),
        Container(
          width: 400,
          height: 139,
          margin: EdgeInsets.only(left: 14, top: 9),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10 /*itemCount*/,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 139,
              childAspectRatio: 1.13684,
            ),
            itemBuilder: (context, index) =>
                cardItemContainer(context, index, "path"),
          ),
        ),
      ],
    ),
  );
}

/*===============================================================================================
  User stats: Total Months
  ================================================================================================*/
Container buildTotalMonthsContainer(int totalMonths) {
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
                  //===========================================
                  // Total Months of Impact
                  //===========================================
                  totalMonths.toString(),
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
                  child: AutoSizeText(
                    "total months of impact",
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: AppFonts.monthlyImpactText,
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

/*===============================================================================================
  Stream Builder for Months in a row
  ================================================================================================*/
Container buildMonthsInARowContainer(int consecutiveMonths) {
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
                  //===========================================
                  // Total Months of Impact
                  //===========================================
                  consecutiveMonths.toString(),
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
                  child: AutoSizeText(
                    "months in a row of impact",
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: AppFonts.monthlyImpactTextSmall,
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

/*===============================================================================================
  User stats: Months of Impact
  ================================================================================================*/
Container buildImpactContainer(UserStats stats) {
  getCardsHttp('test');
  return Container(
    margin: EdgeInsets.only(left: 5, top: 5, right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          alignment: Alignment.topLeft,
          child: Text(
            "Your Climate Impact:",
            textAlign: TextAlign.left,
            style: AppFonts.screenSubhead,
          ),
        ),
        Row(
          children: [
            Container(
                height: 90,
                width: 90,
                margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 3,
                    // Generate 100 widgets that display their index in the List.
                    children:
                        List.generate(stats.treesThisMonth.toInt(), (index) {
                      return Center(
                        child: Image.asset(
                          "assets/images/icons8-oak-tree-100-2-copy-9.png",
                          //fit: BoxFit.,
                        ),
                      );
                    }))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 34,
                          color: Color.fromARGB(255, 250, 195, 21),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700,
                        ),
                        //================================
                        // treesThisMonth
                        //=================================
                        children: <TextSpan>[
                          new TextSpan(
                            text: stats.treesThisMonth.toString() + " ",
                            style: TextStyle(color: AppColors.highlightYellow),
                          ),
                          new TextSpan(
                            text: "Arbor trees earned this month",
                            style: TextStyle(color: AppColors.primaryDarkGreen),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 34,
                            color: Color.fromARGB(255, 250, 195, 21),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700,
                          ),
                          //================================
                          // treesThisMonth
                          //=================================
                          children: <TextSpan>[
                            new TextSpan(
                              text: stats.totalTrees.toString(),
                              style:
                                  TextStyle(color: AppColors.highlightYellow),
                            ),
                            new TextSpan(
                              text: " all-time!",
                              style:
                                  TextStyle(color: AppColors.primaryDarkGreen),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        buildCardsContainer(),
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 260,
              height: 94,
              child: AutoSizeText(
                'Total Arbor Coins Earned:',
                maxLines: 2,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 34,
                  color: AppColors.primaryDarkGreen,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 95,
              height: 73,
              margin: EdgeInsets.only(right: 5),
              alignment: Alignment.bottomRight,
              child: AutoSizeText(
                stats.totalCoins.toString(),
                maxLines: 1,
                style: TextStyle(
                  fontSize: 34,
                  color: AppColors.highlightYellow,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
