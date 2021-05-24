// @dart=2.9

import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/stripe/one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CartItem.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';

Color blueHighlight = Color.fromARGB(255, 18, 115, 211);
var primaryAccentGreen = Color.fromARGB(255, 65, 127, 69);
var iOsSystemBackgroundsLightSystemBack2 = Color.fromARGB(255, 255, 255, 255);

Widget buildLineItems(List<CartItem> purchaseItemList)
//loop through all items and make into a grid 2x

{
  List<Widget> returnList = new List();
  double totalCost = 0;
  double totalTrees = 0;
  double totalCoins = 0;

  for (var i = 0; i < purchaseItemList.length; i++) {
    //check to see that headers don't match, if so make another area in the cart
    //always do the first one
    if (purchaseItemList[i].boxSelected == true) {
      totalCost += purchaseItemList[i].price;
      totalTrees += purchaseItemList[i].treeCount;
      totalCoins += purchaseItemList[i].coinCount;
      returnList.add(
        Row(
          children: [
            Spacer(
              flex: 50,
            ),
            Container(
              width: 200,
              child: Text(
                purchaseItemList[i].imageText,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Raleway",
                ),
              ),
            ),
            Container(
              width: 50,
              child: Text(
                "\$" + purchaseItemList[i].price.toString().padRight(4, '0'),
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

  analytics.logEvent(name: 'begin_checkout', parameters: {
    'count': returnList.length,
    'total': totalCost.toStringAsFixed(2).padRight(4, '0'),
    'coins': totalCoins,
  });

  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: returnList,
      ),
    ),
  );
}

class CheckoutCartContents extends StatefulWidget {
  @override
  _CheckoutCartContentsState createState() => _CheckoutCartContentsState();
  final List<CartItem> purchaseItemList;
  const CheckoutCartContents(this.purchaseItemList);
}

class _CheckoutCartContentsState extends State<CheckoutCartContents> {
  bool isSubscription = false;

  @override
  Widget build(BuildContext context) {
    return checkoutCartDialogue(context);
  }

  Container checkoutCartDialogue(
    BuildContext context,
  ) {
    String projectName;
    double totalTrees = 0;
    double totalCoins = 0;
    double totalMoney = 0;

    print('Project Number:${userdata.selectedprojectnumber}');
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(8, 16, 16, 12),
            child: Text(
              "Shopping Cart:",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w800),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: databaseReference
                .collection("projects")
                .where('projectnumber',
                    isEqualTo: userdata.selectedprojectnumber)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              }
              try {
                snapshot.data.docs[0].get('image-main');
                //String imageLink = snapshot.data.docs[0].data()['image-main'];
                String imageLink = snapshot.data.docs[0].get('image-main');
                //projectName = snapshot.data.docs[0].data()['title'];
                projectName = snapshot.data.docs[0].get('title');
                projectName = projectName.split(":")[1];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(imageLink),
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
                            projectName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontFamily: "Raleway",
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } catch (e) {
                print("Error was: " + e.toString());
                return Text("trouble getting image");
              }
            },
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
          buildLineItems(widget.purchaseItemList),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        "Repeat this purchase monthly:",
                        textAlign: TextAlign.left,
                        style: AppFonts.impactHead,
                      ))),
              Align(
                child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Switch.adaptive(
                        activeColor: Colors.green,
                        value: isSubscription,
                        onChanged: repeatPurchaseOnChanged)),
              )
            ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 27,
                ),
                Expanded(
                  flex: 354,
                  child: Text(
                    "When toggled on, you'll fund the above impact on the climate every month until canceled.",
                    textAlign: TextAlign.center,
                    style: AppFonts.smallIncidentals,
                  ),
                ),
                Spacer(
                  flex: 27,
                ),
              ]),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: _customButton(
              "Continue Checkout",
              () async {
                analytics.logEvent(name: 'purchase');
                onCheckoutLoading(context);
                String sessionId = 'error';
                //final sessionId = await Server().createCheckout();
                print(widget.purchaseItemList[0].documentID);
                print(widget.purchaseItemList[0].imageText);

                //String checkoutJson;
                var checkoutList = [];
                var orderList = [];

                for (var i = 0; i < widget.purchaseItemList.length; i++) {
                  //check to see that headers don't match, if so make another area in the cart
                  //always do the first one
                  if (widget.purchaseItemList[i].boxSelected == true) {
                    checkoutList.add(
                      {
                        'docID': widget.purchaseItemList[i].documentID,
                        'quantity': 1
                      },
                    );

                    orderList.add({
                      'item': widget.purchaseItemList[i].imageText,
                      'quantity': 1,
                      'trees': widget.purchaseItemList[i].treeCount
                    });

                    totalTrees += widget.purchaseItemList[i].treeCount;
                    totalCoins += widget.purchaseItemList[i].coinCount;
                    totalMoney += widget.purchaseItemList[i].price;
                  }
                }

                String customerId;
                bool isCustomer;

                print(databaseService.uid);

                // var sub = databaseReference
                //     .collection("users")
                //     .doc(databaseService.uid)
                //     .snapshots()
                //     .listen((event) {
                //   if (event.data().containsKey("customerId")) {
                //     print("reach1");
                //     isCustomer = true;
                //     event.get("customerId");
                //   } else {
                //     print("reach2");
                //     isCustomer = false;
                //   }
                // });

                print("reach4");
                DocumentSnapshot ds = await databaseReference
                    .collection('users')
                    .doc(databaseService.uid)
                    .get();
                print("reach5");

                isCustomer = ds.data().containsKey("customerId");

                print(isCustomer);

                // if (ds.exists) {
                //   customerId = ds.get('customerId');
                //   print("customer Id doesn't exist");
                // } else {
                //   print("Error: customer ID is empty");
                // }
                // print("AAAAAAAAAAAAAAAAAAA" + isCustomer.toString());

                http.Response response;
                print(databaseService.uid);

                if (!isSubscription) {
                  // First Ping Firebase for session ID for stripe checkout
                  response = await http.post(
                    Uri.parse(
                        'https://us-central1-financeapp-2c7b8.cloudfunctions.net/payment'),
                    body: json.encode(
                      {
                        'items': checkoutList,
                        'projectName': 'project number: ' +
                            userdata.selectedprojectnumber.toString()
                      },
                    ),
                  );
                } else if (isCustomer) {
                  print("this is correct");
                  customerId = ds.get("customerId");
                  response = await http.post(
                    Uri.parse(
                        'https://us-central1-financeapp-2c7b8.cloudfunctions.net/existingCustomerSub'),
                    body: json.encode(
                      {
                        'customerIdClient': customerId,
                        'items': checkoutList,
                        'projectId': userdata.selectedprojectnumber.toString(),
                        'projectTitle': userdata.selectedProjectTitle,
                      },
                    ),
                    // body: json.encode(
                    //   {'priceId': 'price_1ILfIoL6r6kEK5q6zRX4hDpk'},
                    // ),
                  );
                } else {
                  print("this is incorrect");
                  response = await http.post(
                    Uri.parse(
                        'https://us-central1-financeapp-2c7b8.cloudfunctions.net/newCustomerSub'),
                    body: json.encode(
                      {
                        'userId': databaseService.uid,
                        'items': checkoutList,
                        'projectId': userdata.selectedprojectnumber.toString(),
                        'projectTitle': userdata.selectedProjectTitle,
                      },
                    ),
                    // body: json.encode(
                    //   {'priceId': 'price_1ILfIoL6r6kEK5q6zRX4hDpk'},
                    // ),
                  );
                }
                // First Ping Firebase for session ID for stripe checkout
                Navigator.pop(context);

                print(jsonDecode(response.body));

                //then decode the json returned
                if (response.body != null && response.body != 'error') {
                  sessionId = jsonDecode(response.body)['id'];
                  print('Checkout Success!!!!');
                  analytics.logEvent(name: 'purchase', parameters: {
                    'items': widget.purchaseItemList.length,
                    'trees': totalTrees,
                    'coins': totalCoins,
                    'total': totalMoney
                  });
                }

                if (sessionId != 'error') {
                  // Call the one time checkout screen with session ID
                  final outcome =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => OneTimeCheckout(
                                sessionId: sessionId,
                              )));
                  if (outcome == "success") {
                    analytics.logEvent(name: 'purchase_complete', parameters: {
                      'items': widget.purchaseItemList.length,
                      'trees': totalTrees,
                      'coins': totalCoins,
                      'total': totalMoney
                    });

                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                    //databaseService.addOrder(order_list, totalTrees);
                    databaseService.addOrderTest(
                        orderList, totalTrees, totalCoins.toInt());

                    paymentSuccessBuildDialogue(
                        context, totalCoins, totalTrees);
                  } else if (outcome == "failure") {
                    print("Payment was a failure");
                    analytics.logEvent(name: 'purchase_failure');

                    Navigator.of(context).pop();
                    paymentFailureBuildDialogue(context);
                  }
                  final snackBar =
                      SnackBar(content: Text('SessionId: $sessionId'));
                  //Scaffold.of(context).showSnackBar(snackBar);
                  //_congratulationsDialogue();
                } else {
                  analytics.logEvent(name: 'purchase_checkout_fail');
                  print('Checkout Entry has failed');
                }
              },
            ),
          ),
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

  void repeatPurchaseOnChanged(bool newVal) {
    setState(() {
      isSubscription = newVal;
    });
  }
}

void onChanged(bool value) {}

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
            failureDialogue(context),
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

Container failureDialogue(BuildContext context) {
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

Future paymentSuccessBuildDialogue(
    BuildContext context, double totalCoins, double totalTrees) {
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
            successDialogue(context, totalCoins.toInt(), totalTrees.toInt()),
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

Container successDialogue(
    BuildContext context, int totalCoins, int totalTrees) {
  String projectName;

  print('Project Number:${userdata.selectedprojectnumber}');
  return Container(
    //alignment: Alignment.topCenter,
    padding: EdgeInsets.all(0),
    //constraints: BoxConstraints.expand(),
    child: Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: databaseReference
              .collection("projects")
              .where('projectnumber', isEqualTo: userdata.selectedprojectnumber)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            }
            try {
              String imageLink = snapshot.data.docs[0].data()['image-main'];
              projectName = snapshot.data.docs[0].data()['title'];
              projectName = projectName.split(":")[1];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imageLink),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 16, 16, 12),
                    child: Text(
                      "Congratulations!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36,
                          color: AppColors.primaryDarkGreen,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "You Funded:",
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
                          projectName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } catch (e) {
              print("Error was: " + e.toString());
              return Text("trouble getting image");
            }
          },
        ),
        Container(
          margin: EdgeInsets.fromLTRB(9, 20, 9, 20),
          child: Text(
            "Funding your project reverses your climate impact. You’re helping reverse climate change!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 265,
              height: 52,
              child: AutoSizeText(
                'Arbor Trees Earned:',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 27,
                  color: AppColors.primaryDarkGreen,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: 75,
              height: 52,
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                totalTrees.toString(),
                maxLines: 1,
                style: TextStyle(
                  fontSize: 27,
                  color: AppColors.highlightYellow,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20),
              width: 265,
              height: 52,
              child: AutoSizeText(
                'Arbor Coins Earned:',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 27,
                  color: AppColors.primaryDarkGreen,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.centerRight,
              width: 75,
              height: 52,
              child: AutoSizeText(
                totalCoins.toString(),
                maxLines: 1,
                style: TextStyle(
                  fontSize: 27,
                  color: AppColors.highlightYellow,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
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
        _customButton("Share", () async {
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

Container successDialogueBak(double totalCoins, double totalTrees) {
  return Container(
    alignment: Alignment.topCenter,
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
        Spacer(
          flex: 38,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "Congratulations!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(
          flex: 25,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "By eliminating your climate impact, you're helping reversing climate change!",
            textAlign: TextAlign.center,
            style: AppFonts.congratsSubhead,
          ),
        ),
        Spacer(
          flex: 110,
        ),
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
      color: AppColors.backgroundBlue,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  );
}
