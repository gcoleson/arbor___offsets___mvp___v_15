// @dart=2.9

import 'dart:convert';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/shopping_cart_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'UserStats.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloudFirestore;

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
    BuildContext context, int index, CardListDataClass info, bool dummyCard) {
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
                iconSize: dummyCard ? 24 : 139,
                icon: dummyCard
                    ? Image.asset("assets/images/icons8Lock100Copy3.png")
                    : Image.network(info.imageLink),
                onPressed: () {
                  if (!dummyCard)
                    cardDetailDialogue(
                        context,
                        dummyCard
                            ? Image.asset(
                                "assets/images/icons8Lock100Copy3.png")
                            : Image.network(info.imageLink),
                        "Discovered ${DateFormat.yMMMd().format(info.date)} for ${info.description}",
                        info.extraInfo);
                },
              )),
        ),
      ],
    ),
  );
}
//var formattedDate = DateFormat.yMMMd().format(info.date);

Future cardDetailDialogue(
    BuildContext context, Image image, String description, String funFact) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0.0),
        insetPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Stack(
          fit: StackFit.expand,
          children: [
            cardDialogue(image, description, funFact),
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

Container cardDialogue(Image image, String description, String funFact) {
  return Container(
    padding: EdgeInsets.all(0),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image,
        ),
        Container(
          height: 66,
          width: 358,
          padding: EdgeInsets.fromLTRB(8, 16, 16, 12),
          child: AutoSizeText(
            description,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: AppColors.primaryDarkGreen,
                fontFamily: "Railway",
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 57,
          width: 358,
          padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
          child: AutoSizeText(
            funFact,
            maxLines: 2,
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

  print("getCardHttp:${cardList.length}:${cardListData.length}");

  if (cardList.length != 0) {
    if (cardListData.length == 0) {
      for (var i = 0; i < cardList.length; i++) {
        CardListDataClass info = CardListDataClass();

        print(
            "list:${cardList[i]["cardIndex"]} ${cardList[i]["imageLink"]} ${cardList[i]["date"]} ${cardList[i]["description"]} ${cardList[i]["extraInfo"]}");

        print(cardList[i]['cardIndex'].toString());
        info.cardIndex = int.parse(cardList[i]['cardIndex'].toString());
        //save max card index
        if (info.cardIndex > maxCardIndex) maxCardIndex = info.cardIndex;

        info.imageLink = cardList[i]['imageLink'].toString();
        info.extraInfo = cardList[i]['extraInfo'].toString();
        info.description = cardList[i]['description'].toString();
        info.date = DateTime.parse(cardList[i]['date'].toString());

        cardListData.add(info);
      }
      //cardListData.sort((a, b) => a.cardIndex.compareTo(b.cardIndex));
      print("max card index:$maxCardIndex");
    }
    return;
  }

  Future<http.Response> response = http.post(
      Uri.parse(
          'https://us-central1-financeapp-2c7b8.cloudfunctions.net/getCards'),
      //'https://us-central1-financeapp-2c7b8.cloudfunctions.net/testCards'),
      body: json.encode(
        {
          'userId': uid,
        },
      ));

  response.then((value) {
    getCardsHttpResponse(value);
  });
}

void Function() localcallSetState;

void sendCallSetState(void Function() callSetState) {
  localcallSetState = callSetState;
}

class CardListDataClass {
  int cardIndex = 0;
  String imageLink = "assets/images/icons8Lock100Copy3.png";
  DateTime date = DateTime(2012);
  String extraInfo = "";
  String description = "";
}

List<CardListDataClass> cardListData = [];
int maxCardIndex = 0;

getCardsHttpResponse(http.Response response) {
  print(jsonDecode(response.body));

  print("cardList loaded");

  if (response.body != 'error') {
    cardList = jsonDecode(response.body)['cardList'];
    print("list len:${cardList.length}");

    for (var i = 0; i < cardList.length; i++) {
      CardListDataClass info = CardListDataClass();

      print(
          "list:${cardList[i]["cardIndex"]} ${cardList[i]["imageLink"]} ${cardList[i]["date"]} ${cardList[i]["description"]} ${cardList[i]["extraInfo"]}");

      print(cardList[i]['cardIndex'].toString());
      info.cardIndex = int.parse(cardList[i]['cardIndex'].toString());
      //save max card index
      if (info.cardIndex > maxCardIndex) maxCardIndex = info.cardIndex;

      info.imageLink = cardList[i]['imageLink'].toString();
      info.extraInfo = cardList[i]['extraInfo'].toString();
      info.description = cardList[i]['description'].toString();
      info.date = DateTime.parse(cardList[i]['date'].toString());

      cardListData.add(info);
    }
    //sort by index
    //cardListData.sort((a, b) => a.cardIndex.compareTo(b.cardIndex));
    print("max card index:$maxCardIndex");
  }

  localcallSetState();
}

Container buildCardsContainer() {
  return Container(
    width: 416,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            /* Container(
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
            Spacer(),*/
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
            /* Spacer(),
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
            ), */
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
            itemCount: cardListData.length != 0 ? maxCardIndex : 1,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 139,
              childAspectRatio: 1.13684,
            ),
            itemBuilder: (context, index) {
              print("index:$index");
              if (cardListData.length == 0) {
                //if we don't have any data put up a dummy card
                CardListDataClass dummy;
                return cardItemContainer(context, index, dummy, true);
              } else {
                //we have processed http return and have a list of cards
                //need to look for a card that matches index or
                //if there is no index match return dummy card

                CardListDataClass dummy;
                bool dummyCard = true;

                cardListData.forEach((element) {
                  if (element.cardIndex == (index + 1)) {
                    print("element=${element.cardIndex}");
                    dummy = element;
                    dummyCard = false;
                    return cardItemContainer(context, index, element, false);
                  }
                });

                //returning dummy
                return cardItemContainer(context, index, dummy, dummyCard);
              }
            },
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
  activateFirstCard();
  getCardsHttp(databaseService.uid);
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

Future activateFirstCard() async {
  String lastDateString = await readLastFreebieCardDate();

  if (lastDateString == "empty") {
    return;
  }
  DateTime lastDateWrite = DateTime.parse(lastDateString);
  DateTime currentDate = DateTime.now();
  String dateId = currentDate.year.toString() +
      currentDate.month.toString().padLeft(2, "0");
  int monthDifference = monthDiff(lastDateWrite, currentDate);
  if (monthDifference > 0) {
    cloudFirestore.DocumentSnapshot userCardSnapshot = await databaseReference
        .collection('users')
        .doc(databaseService.uid)
        .collection('cards')
        .doc(dateId)
        .get();
    bool isUserCardsActivated = userCardSnapshot.exists;
    if (!isUserCardsActivated) {
      databaseService.addCard(dateId, "Monthly Open", isUserCardsActivated);
      isUserCardsActivated = true;
    } else {
      databaseService.addCard(dateId, "Monthly Open", isUserCardsActivated);
    }
    writeLastFreebieCardDate();
  }
}

int monthDiff(DateTime dateFrom, DateTime dateTo) {
  return dateTo.month - dateFrom.month + (12 * (dateTo.year - dateFrom.year));
}

Future readLastFreebieCardDate() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "lastFreebieCardMonth";
  final value = prefs.getString(key) ?? "empty";
  print("read: $value");
  return value;
}

void writeLastFreebieCardDate() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "lastFreebieCardMonth";
  String date = DateTime.now().toIso8601String();
  prefs.setString(key, date);
}
