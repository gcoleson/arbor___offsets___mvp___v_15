// @dart=2.9

import 'dart:convert';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
import 'package:arbor___offsets___mvp___v_15/dashboard_widget/shopping_cart_widget.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/project_blandfill_gas_item_widget.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../main.dart';
import 'UserStats.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloudFirestore;
import '../main.dart' as main;
import 'package:arbor___offsets___mvp___v_15/values/constants.dart';

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
  Build container reward cards
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
              color: AppColors.transparentScreen,
              border: Border.all(
                width: 1,
                color: AppColors.darkGrey,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow,
                  offset: dummyCard ? Offset(0, 1) : Offset(0, 2),
                  blurRadius: dummyCard ? 0 : 4,
                ),
              ],
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
                padding: EdgeInsets.all(dummyCard ? 0 : 2),
                iconSize: dummyCard ? 24 : 139,
                icon: dummyCard
                    ? Image.asset("assets/images/icons8Lock100Copy3.png")
                    : Image.network(
                        info.imageLink,
                        loadingBuilder: loadingBuilder2,
                      ),
                onPressed: () {
                  main.analytics.logEvent(name: 'Reward_card_tap', parameters: {
                    'reward_card_name': info.description,
                    'reward_card_number': info.cardIndex
                  });
                  // if (!dummyCard)
                  cardDetailDialogue(
                      context,
                      dummyCard
                          ? Image.asset("assets/images/icons8Lock100Copy3.png")
                          : Image.network(
                              info.imageLink,
                              loadingBuilder: loadingBuilder2,
                            ),
                      Image.asset("assets/images/Frame 4.png"),
                      "Discovered ${DateFormat.yMMMd().format(info.date)} for ${info.description}",
                      info.extraInfo,
                      dummyCard);
                },
              )),
        ),
      ],
    ),
  );
}

Future cardDetailDialogue(BuildContext context, Image image, Image lockedImage,
    String description, String funFact, bool lock) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.all(0.0),
        insetPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Stack(
          children: [
            SingleChildScrollView(
                child: lock
                    ? lockedCardDialogue(lockedImage,
                        'Unlock this by offsetting negative climate impacts!')
                    : cardDialogue(image, description, funFact)),
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
                      fontWeight: FontWeight.bold,
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

/*===============================================================================================
  Build dialog for locked card 
  ================================================================================================*/
Container lockedCardDialogue(Image image, String desc) {
  return Container(
      color: AppColors.borderGrey,
      padding: EdgeInsets.all(11),
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(11, 16, 11, 15),
          child: Text(
            desc,
            textAlign: TextAlign.left,
            style: AppFonts.RewardCaredDescriptionText,
          ),
        )
      ]));
}

/*===============================================================================================
  Build dialog for unlocked card 
  ================================================================================================*/
Container cardDialogue(Image image, String description, String funFact) {
  return Container(
    padding: EdgeInsets.all(11),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(11, 16, 11, 15),
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: AppFonts.RewardCaredDescriptionText,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(6, 11, 11, 15),
          child: Text(
            funFact,
            textAlign: TextAlign.right,
            style: AppFonts.percentFunded,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.fromLTRB(0, 11, 11, 0),
          child: Text(
            "Tell your friends how you're going climate positive:",
            textAlign: TextAlign.center,
            style: AppFonts.checkoutBodyText,
          ),
        ),
        customButton("Share", () async {
          await Share.share(
              'I’m fighting climate change—sign up here to join me! https://getarborapp.com/',
              subject: 'Arbor');
          analytics.logEvent(name: 'Share_reward');
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

void refreshDashboard() {
  //clear out card data and get it again
  cardList.clear();
  cardListData.clear();

  //refresh UI
  localcallSetState();
}

List<dynamic> cardList = [];
String dateKey = "202107";

getCardsHttp(String uid, String dateKeyCustom) {
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

  int curMonth = DateTime.now().month;
  int curYear = DateTime.now().year;
  String dateKey = curYear.toString() + curMonth.toString().padLeft(2, "0");
  Future<http.Response> response = http.post(
      Uri.parse(
          'https://us-central1-financeapp-2c7b8.cloudfunctions.net/getCards'),
      body: json.encode(
        {'userId': uid, 'date': dateKeyCustom},
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
String collectionName = "";
DateTime cardDateKey = DateTime.now();
String cardKeyMax = DateTime.now().year.toString() +
    DateTime.now().month.toString().padLeft(2, "0");
bool isEndLeft = false;
bool isEndRight = true;
String dateTitle = "This Month's Collection:";

getCardsHttpResponse(http.Response response) {
  print(jsonDecode(response.body));

  print("cardList loaded");

  if (response.body != 'error') {
    dynamic jsonRes = jsonDecode(response.body);
    Map metadata = jsonRes["metadata"];
    cardList = jsonRes['cardList'];
    collectionName = metadata["collectionName"];

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

void loadPrevMonthCards() {
  DateTime tempDateTime = new DateTime(cardDateKey.year, cardDateKey.month - 1);
  int tempYearKey = tempDateTime.year;
  int tempMonthKey = tempDateTime.month;
  String tempKey =
      tempYearKey.toString() + tempMonthKey.toString().padLeft(2, "0");
  if (tempKey.compareTo(cardKeyMin) > -1) {
    dateKey = tempKey;
    cardDateKey = tempDateTime;
    isEndRight = false;
  }

  if (tempKey.compareTo(cardKeyMin) <= 0) {
    isEndLeft = true;
    dateTitle =
        months[cardDateKey.month - 1] + " " + cardDateKey.year.toString();
  } else {
    isEndLeft = false;
  }
  print("Queried Card Collection is: " + dateKey);
  refreshDashboard();
}

void loadNextMonthCards() {
  DateTime tempDateTime = new DateTime(cardDateKey.year, cardDateKey.month + 1);
  int tempYearKey = tempDateTime.year;
  int tempMonthKey = tempDateTime.month;
  String tempKey =
      tempYearKey.toString() + tempMonthKey.toString().padLeft(2, "0");
  print("temp key value is: " + tempKey);
  print("max value is: " + cardKeyMax);
  if (tempKey.compareTo(cardKeyMax) < 1) {
    dateKey = tempKey;
    cardDateKey = tempDateTime;
    isEndLeft = false;
  }

  if (tempKey.compareTo(cardKeyMax) == 0) {
    isEndRight = true;
    dateTitle = "This Month's Collection:";
  } else if (tempKey.compareTo(cardKeyMax) == 1) {
    isEndRight = true;
    dateTitle =
        months[cardDateKey.month - 1] + " " + cardDateKey.year.toString();
  } else {
    isEndRight = false;
  }
  print("Queried Card Collection is: " + dateKey);
  refreshDashboard();
}

Container buildCardsContainer() {
  return Container(
    width: 416,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: isEndLeft ? null : loadPrevMonthCards,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: isEndLeft
                  ? null
                  : Container(
                      width: 30,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "<",
                        style: AppFonts.treeImpactText,
                      ),
                    ),
            ),

            //alignment: Alignment.center,
            //margin: EdgeInsets.only(left: 20, right: 20),
            Flexible(
              fit: FlexFit.tight,
              child: AutoSizeText(
                dateTitle,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: AppFonts.screenSubhead,
              ),
            ),

            TextButton(
              onPressed: isEndRight ? null : loadNextMonthCards,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: isEndRight
                  ? null
                  : Container(
                      width: 30,
                      alignment: Alignment.centerRight,
                      child: Text(
                        ">",
                        style: AppFonts.treeImpactText,
                      ),
                    ),
            ),
          ],
        ),
        Container(
          width: 382,
          margin: EdgeInsets.only(left: 4, top: 2),
          child: AutoSizeText(
            collectionName,
            maxLines: 2,
            textAlign: TextAlign.right,
            style: AppFonts.treeImpactText,
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
                  // find matching index
                  if (element.cardIndex == (index + 1)) {
                    //print("element=${element.cardIndex}");
                    dummy = element;
                    dummyCard = false;
                    return cardItemContainer(context, index, element, false);
                  }
                });

                // if card is set to empty then display locked dummy card
                if (dummyCard == false && dummy.description == "empty") {
                  dummyCard = true;
                }
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
              color: AppColors.secondaryLightGreen,
              border: Border.all(
                width: 1,
                color: AppColors.borderGrey,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow,
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
                  style: AppFonts.treeImpactTextGold,
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
                  style: AppFonts.treeImpactTextGold,
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
  User stats: Months of Impact
  ================================================================================================*/
Container buildImpactContainer(UserStats stats) {
  activateFirstCard();
  getCardsHttp(databaseService.uid, dateKey);
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
                        style: AppFonts.treeImpactTextGold,
                        //================================
                        // treesThisMonth
                        //=================================
                        children: <TextSpan>[
                          new TextSpan(
                            text: stats.treesThisMonth.toString() + " ",
                            style: AppFonts.treeImpactTextGold,
                          ),
                          new TextSpan(
                            text: "Arbor trees earned this month",
                            style: AppFonts.treeImpactText,
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
                          style: AppFonts.treeImpactTextGold,
                          //================================
                          // treesThisMonth
                          //=================================
                          children: <TextSpan>[
                            new TextSpan(
                              text: stats.totalTrees.toString(),
                              style: AppFonts.treeImpactTextGold,
                            ),
                            new TextSpan(
                              text: " all-time!",
                              style: AppFonts.treeImpactText,
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
              child: Text(
                'Total Arbor Coins Earned:',
                maxLines: 2,
                textAlign: TextAlign.right,
                style: AppFonts.treeImpactText,
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
                style: AppFonts.treeImpactTextGold,
              ),
            )
          ],
        )
      ],
    ),
  );
}

/*===============================================================================================
  Freebie card: when the user opens the app for the first time reward first card
  ================================================================================================*/
Future activateFirstCard() async {
  // check the last successful access freebie date
  String lastDateString = await readLastFreebieCardDate();

  // get current date to test for user card database existence
  DateTime currentDate = DateTime.now();
  String dateId = currentDate.year.toString() +
      currentDate.month.toString().padLeft(2, "0");

  // query database for list
  cloudFirestore.DocumentSnapshot userCardSnapshot = await databaseReference
      .collection('users')
      .doc(databaseService.uid)
      .collection('cards')
      .doc(dateId)
      .get();

  // logic to determine if we write a new card database for the user or not
  bool isUserCardsActivated = userCardSnapshot.exists;

  print("does user cards exist?" + isUserCardsActivated.toString());

  // If last date is empty write the card as normal
  // else check to see if it's a new month
  if (lastDateString == "empty") {
    databaseService.addCard(dateId, "Monthly Open", isUserCardsActivated);
    writeLastFreebieCardDate();
  } else {
    DateTime lastDateWrite = DateTime.parse(lastDateString);
    int monthDifference = monthDiff(lastDateWrite, currentDate);
    if (monthDifference > 0) {
      databaseService.addCard(dateId, "Monthly Open", isUserCardsActivated);
      writeLastFreebieCardDate();
    } else {
      print(
          "sign in is not vlaid for freebie, probably multiple sign ins this month");
    }
  }
}

// helper function to calculate month difference
// TODO: When we have a utils folder move this there
int monthDiff(DateTime dateFrom, DateTime dateTo) {
  return dateTo.month - dateFrom.month + (12 * (dateTo.year - dateFrom.year));
}

// read last time we earned a freebie card
// TODO: this logic should definitely move to the database
// this is only temporary because it was an easy solution
Future readLastFreebieCardDate() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "lastFreebieCardMonth" + databaseService.uid;
  final value = prefs.getString(key) ?? "empty";
  print("read: $value");
  return value;
}

// write date to preferences if freebie card earned
// TODO: this logic should definitely move to the database
// this is only temporary because it was an easy solution
void writeLastFreebieCardDate() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "lastFreebieCardMonth" + databaseService.uid;
  String date = DateTime.now().toIso8601String();
  prefs.setString(key, date);
}
