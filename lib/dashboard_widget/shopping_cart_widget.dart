import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/stripe/one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CartItem.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    decoration: BoxDecoration(
        color: blueHighlight, borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text("Congratulations!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xfffafcfd),
                fontSize: 36,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              )),
        ),
        Spacer(flex: 25),
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "By eliminating your climate impact, you’re helping reversing climate change!",
            textAlign: TextAlign.center,
            style: AppFonts.congratsSubhead,
          ),
        ),
        //TODO: Finish the share feature
        // Text("You just eliminated the climate impact of:",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontFamily: 'Montserrat',
        //       color: iOsSystemBackgroundsLightSystemBack2,
        //       fontSize: 28,
        //       fontWeight: FontWeight.w500,
        //       fontStyle: FontStyle.normal,
        //     )),
        Spacer(
          flex: 110,
        ),
        // Text("Tell your friends how you’re going climate positive:",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontFamily: 'Raleway',
        //       color: Color(0xff010101),
        //       fontSize: 18,
        //       fontWeight: FontWeight.w300,
        //       fontStyle: FontStyle.normal,
        //     )),
        // Container(
        //   width: 344,
        //   height: 50,
        //   decoration: BoxDecoration(
        //       color: primaryAccentGreen,
        //       borderRadius: BorderRadius.circular(8)),
        //   child: Text(
        //     "Share",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontFamily: 'SFProText',
        //       color: iOsSystemBackgroundsLightSystemBack2,
        //       fontSize: 17,
        //       fontWeight: FontWeight.w600,
        //       fontStyle: FontStyle.normal,
        //       letterSpacing: -0.408,
        //     ),
        //   ),
        // )
      ],
    ),
  );

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
//}

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

Container checkoutCartDialogue(
    BuildContext context, List<CartItem> purchaseItemList) {
  String projectName;
  double totalTrees = 0;
  double totalCoins = 0;
  double totalMoney = 0;

  return Container(
    alignment: Alignment.topCenter,
    //margin: EdgeInsetsGeometry.infinity,
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
        buildLineItems(purchaseItemList),
        SizedBox(height: 17.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                child: Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Text(
                      "Repeat this purchase monthly:",
                      textAlign: TextAlign.left,
                      style: AppFonts.impactHead,
                    ))),
            Align(
              child: Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: Switch.adaptive(
                  value: val,
                  onChanged: temp,
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                ),
              ),
              /*Switch(
                              value: val,
                              onChanged: (bool v) {
                                setState(() {
                                  val = v;
                                  print(val);
                                });
                                //activeColor: Colors.green),
                                // Text(message)
                              },
                            ), */
            )
          ],
        ),
        SizedBox(height: 8),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 354,
                height: 56,
                child: Text(
                  "When toggled on, you'll erase the above action automatically every month until canceled.",
                  textAlign: TextAlign.center,
                  style: AppFonts.smallIncidentals,
                ),
              )
            ]),
        Container(
          padding: EdgeInsets.fromLTRB(8, 11, 8, 11),
          child: Text(
            "Eliminate your climate impact now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 28,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: _customButton(
            "Continue Checkout",
            () async {
              analytics.logEvent(name: 'purchase');
              onCheckoutLoading(context);
              String sessionId = 'error';
              //final sessionId = await Server().createCheckout();
              print(purchaseItemList[0].documentID);
              print(purchaseItemList[0].imageText);

              String checkout_json;
              var checkout_list = [];
              var order_list = [];

              for (var i = 0; i < purchaseItemList.length; i++) {
                //check to see that headers don't match, if so make another area in the cart
                //always do the first one
                if (purchaseItemList[i].boxSelected == true) {
                  checkout_list.add(
                    {'docID': purchaseItemList[i].documentID, 'quantity': 1},
                  );

                  order_list.add({
                    'item': purchaseItemList[i].imageText,
                    'quantity': 1,
                    'trees': purchaseItemList[i].treeCount
                  });

                  totalTrees += purchaseItemList[i].treeCount;
                  totalCoins += purchaseItemList[i].coinCount;
                  totalMoney += purchaseItemList[i].price;
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

              if (isCustomer) {
                print("this is correct");
                customerId = ds.get("customerId");
                response = await http.post(
                  'https://us-central1-financeapp-2c7b8.cloudfunctions.net/stripeDevelop',
                  body: json.encode(
                    {
                      'customerIdClient': customerId,
                      'items': checkout_list,
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
                  'https://us-central1-financeapp-2c7b8.cloudfunctions.net/stripeDevelop2',
                  body: json.encode(
                    {
                      'items': checkout_list,
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
                  'items': purchaseItemList.length,
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
                    'items': purchaseItemList.length,
                    'trees': totalTrees,
                    'coins': totalCoins,
                    'total': totalMoney
                  });

                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  databaseService.addOrder(order_list, totalTrees);

                  paymentSuccessBuildDialogue(context);
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
    // child: Stack(
    //   fit: StackFit.loose,
    //   children: [
    //     Image.asset("assets/images/WelcomeBackScreen.png"),
    //   ],
    // ),
  );
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
        // Text(
        //   "Tell your freinds how you're going climate positive:",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 18,
        //     color: Colors.black,
        //     fontFamily: "Raleway",
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
        // Spacer(),
        // _customButton("Share", () {}),
        // Spacer(),
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

bool val = false;
var textValue = 'Switch off';
// void switchChanged(bool value) {
//   if (val == false) {
//     setState(() {
//       val = true;
//     });
//   } else
//     setState(() {
//       val = false;
//     });
// }

void temp(bool val) {
  return;
}

//void setState(Null Function() param0) {}
