import 'dart:convert';

import 'package:flutter/material.dart';
import 'one_time_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class checkout_entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: RaisedButton(
            onPressed: () async {
              String sessionId = 'error';
              //final sessionId = await Server().createCheckout();

              // First Ping Firebase for session ID for stripe checkout
              final http.Response response = await http.post(
                'https://us-central1-financeapp-2c7b8.cloudfunctions.net/payment/',
                body: json.encode(
                  {'price': 1337, 'product': 'A flight'},
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
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => OneTimeCheckout(
                          sessionId: sessionId,
                        )));
                final snackBar =
                    SnackBar(content: Text('SessionId: $sessionId'));
                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                print('Checkout Entry has failed');
              }
            },
          ),
        ),
      ),
    );
  }
}
