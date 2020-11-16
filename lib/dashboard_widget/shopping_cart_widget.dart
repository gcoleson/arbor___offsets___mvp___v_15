import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/stripe/one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CartItem.dart';

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
          Spacer(),
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
//}

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
            //Text("data")
            checkoutCartDialogue(context, purchaseItemList),
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

Container buildLineItems(List<CartItem> purchaseItemList)
//loop through all items and make into a grid 2x
{
  SingleChildScrollView productColumn;
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

Container checkoutCartDialogue(
    BuildContext context, List<CartItem> purchaseItemList) {
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
        buildLineItems(purchaseItemList),
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
            String sessionId = 'error';
            //final sessionId = await Server().createCheckout();
            print(purchaseItemList[0].documentID);
            print(purchaseItemList[0].imageText);

            String checkout_json;
            var checkout_list = [];

            for (var i = 0; i < purchaseItemList.length; i++) {
              //check to see that headers don't match, if so make another area in the cart
              //always do the first one
              if (purchaseItemList[i].boxSelected == true) {
                checkout_list.add(
                  {'docID': purchaseItemList[i].documentID, 'quantity': 1},
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

                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
                paymentSuccessBuildDialogue(context);
              } else if (outcome == "failure") {
                print("Payment was a failure");
                Navigator.of(context).pop();
                paymentFailureBuildDialogue(context);
              }
              final snackBar = SnackBar(content: Text('SessionId: $sessionId'));
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
