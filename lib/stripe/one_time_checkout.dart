// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OneTimeCheckout extends StatefulWidget {
  final String sessionId;

  const OneTimeCheckout({Key key, this.sessionId}) : super(key: key);
  @override
  _OneTimeCheckoutState createState() => _OneTimeCheckoutState();
}

class _OneTimeCheckoutState extends State<OneTimeCheckout> {
  WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 127, 69),
      body: SafeArea(
        child: WebView(
          initialUrl: initialURL,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) =>
              controller = webViewController,
          onPageFinished: (String url) {
            if (url == initialURL) {
              redirectToStripe();
            }
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://yoursite.com/success.html')) {
              Navigator.of(context).pop('success');
            } else if (request.url.startsWith('https://example.com/cancel')) {
              Navigator.of(context).pop('cancel');
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  String get initialURL => 'https://agyscon.github.io/';

  void redirectToStripe() {
    final redirectToCheckoutJs = '''
      var stripe = Stripe('pk_live_51HRfuDL6r6kEK5q6gu926dyT02VZA8q2u3WLUU5HbQVB9CRcvMcphEJOh2qmYkstKSpqo8afWVoHpRqNyDVqe5sb00a7qmwcV8');
      stripe.redirectToCheckout({
        sessionId: '${widget.sessionId}'
      }).then(function (result) {
        result.error.message = 'Error'
      });
      ''';
    controller.evaluateJavascript(redirectToCheckoutJs);
  }
}

const String kStripeHtmlPage = '''
<!DOCTYPE html>
<html style = "background-color: #417F45;">
<script src="https://js.stripe.com/v3/"></script>
<head><title>Stripe checkout</title></head>
<body>
<div style="padding-top: 50px;">
</div>
</body>
</html>
''';
