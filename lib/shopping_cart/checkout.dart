import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class checkoutScreen extends StatefulWidget {
  @override
  _checkoutScreenState createState() => _checkoutScreenState();
}

class _checkoutScreenState extends State<checkoutScreen> {
  //Payment Variables
  double totalCost = 1000;
  double taxPercent = 0.3;
  double tax = 0.03;
  double tip = 2.0;
  double amount;
  String url = '';
  String text = '';

  //Stripe Setup
  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
            'pk_test_51HRfuDL6r6kEK5q693txJKmIcCBzlQmWOmtazwxUUBEBOcegjWezD0C1PupkU3pjCtptns4wAnIFXe1ykZPxNQrw00F47qSNCm', // add you key as per Stripe dashboard
        // add you merchantId as per apple developer account
        androidPayMode: 'test',
      ),
    );
  }

  //Checking Native Pay Status
  void checkIfNativePayReady() async {
    print('started to check if native pay ready');
    // bool deviceSupportNativePay = await StripePayment.deviceSupportsNativePay();
    // bool isNativeReady = await StripePayment.canMakeNativePayPayments(
    //     ['american_express', 'visa', 'maestro', 'master_card']);
    // if (deviceSupportNativePay && isNativeReady) {
    //   createPaymentMethodNative();
    // } else {
    //   createPaymentMethod();
    // }

    createPaymentMethod();
  }

  //Manual Card Payment
  Future<void> createPaymentMethod() async {
    print("jesus take the wheel");
    StripePayment.setStripeAccount(null);

    //Calculate total costs
    tax = ((totalCost * taxPercent));
    amount = ((totalCost + tip + tax));
    print('amount in pence/cent which will be charged = $amount');

    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod =
        await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
            .then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    if (paymentMethod != null) {
      processPaymentAsDirectCharge(paymentMethod);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => ShowDialogToDismess(
          title: 'Error',
          content:
              'It is not possible to pay with this card. Please try again with a different card',
          buttonText: 'CLOSE',
        ),
      );
    }
  }

  // Apple Pay or Google Pay
  Future<void> createPaymentMethodNative() async {
    print('started NATIVE payment...');
    StripePayment.setStripeAccount(null);

    List<ApplePayItem> items = [];

    items.add(ApplePayItem(
      label: 'Demo Order',
      amount: totalCost.toString(),
    ));

    if (tip != 0.0) {
      items.add(ApplePayItem(
        label: 'Tip',
        amount: totalCost.toString(),
      ));
    }

    if (taxPercent != 0.0) {
      tax = ((totalCost * taxPercent) * 100).ceil() / 100;
      items.add(ApplePayItem(
        label: 'Tax',
        amount: tax.toString(),
      ));
    }

    items.add(ApplePayItem(
      label: 'Vendor A',
      amount: (totalCost + tip + tax).toString(),
    ));

    amount = ((totalCost + tip + tax) * 100);

    print('amount in dolalrs which will be charged = $amount');

    PaymentMethod paymentMethod = PaymentMethod();

    Token token = await StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: 'USD',
          totalPrice: (totalCost + tax + tip).toStringAsFixed(2)),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'US',
        currencyCode: 'USD',
        items: items,
      ),
    );

    paymentMethod = await StripePayment.createPaymentMethod(
      PaymentMethodRequest(
        card: CreditCard(
          token: token.tokenId,
        ),
      ),
    );

    if (PaymentMethod != null) {
      processPaymentAsDirectCharge(paymentMethod);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => ShowDialogToDismess(
          title: 'Error',
          content:
              'It is not possible to pay with this card, Please try again with a different card',
          buttonText: 'CLOSE',
        ),
      );
    }
  }

  processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    setState(() {
      showSpinner = true;
    });

    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent

    final http.Response response = await http
        .post('$url?amount=$amount&currency=USD&paym=${paymentMethod.id}');
    print('Now I decode');
    if (response.body != null && response.body != 'error') {
      final paymentIntentX = jsonDecode(response.body);
      final status = paymentIntentX['paymentIntent']['status'];
      final strAccount = paymentIntentX['stripeAccount'];

      if (status == 'succeeded') {
        //payment was confirmed by the server without the need for further authentification
        StripePayment.completeNativePayRequest();
        setState(() {
          text =
              'payment completed. ${paymentIntentX['paymentIntent']['amount'].toString()}p succesfully charged';
          showSpinner = false;
        });
      } else {
        // step4: there is a need to authenticate
        StripePayment.setStripeAccount(strAccount);

        await StripePayment.confirmPaymentIntent(PaymentIntent(
                clientSecret: paymentIntentX['paymentIntent']['client_secret'],
                paymentMethodId: paymentIntentX['paymentIntent']
                    ['payment_method']))
            .then(
          (PaymentIntentResult paymentIntextResult) async {
            // this code will be executed if the authentication is successful
            //step5: request the server to confirm the payment with
            final statusFinal = paymentIntextResult.status;
            if (statusFinal == 'succeeded') {
              StripePayment.completeNativePayRequest();
              setState(() {
                showSpinner = false;
              });
            } else if (statusFinal == 'processing') {
              StripePayment.cancelNativePayRequest();
              setState(() {
                showSpinner = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowDialogToDismess(
                        title: 'Warning',
                        content:
                            'the payment is still in \'processing\' state. this is unusual. Please contact us',
                        buttonText: 'CLOSE',
                      ));
            } else {
              StripePayment.cancelNativePayRequest();
              setState(() {
                showSpinner = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) => ShowDialogToDismess(
                      title: 'Error',
                      content:
                          'There was an error to confirm the payment. Details $statusFinal',
                      buttonText: 'CLOSE'));
            }
          },

          //If Authentication fails, a platform exception wil be raised which can be handled here
        ).catchError((e) {
          //case B1
          StripePayment.cancelNativePayRequest();
          setState(() {
            showSpinner = false;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) => ShowDialogToDismess(
                  title: 'Error',
                  content:
                      'There was an error to confirm the payment. Please try again with another card',
                  buttonText: 'CLOSE'));
        });
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();

      setState(() {
        showSpinner = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => ShowDialogToDismess(
                title: 'Error',
                content:
                    'there was an error in creating the payment. Please try again with another card',
                buttonText: 'CLOSE',
              ));
    }
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toString()),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  checkIfNativePayReady();
                },
                child: Text(
                  "Pay \$10",
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(28.0),
                splashColor: Colors.blueAccent,
              ),
              Divider(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "click the button to start the payment",
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDialogToDismess extends StatelessWidget {
  final String content;
  final String title;
  final String buttonText;

  ShowDialogToDismess({this.title, this.buttonText, this.content});

  @override
  Widget build(BuildContext context) {
    if (IO.Platform.isIOS) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(this.content),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text(buttonText))
        ],
      );
    } else {
      return CupertinoAlertDialog(title: Text(title), actions: <Widget>[
        CupertinoDialogAction(
            child: new Text(
              buttonText[0].toUpperCase() +
                  buttonText.substring(1).toLowerCase(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ]);
    }
  }
}
