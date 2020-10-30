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
      body: WebView(
        initialUrl: initialURL,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) => controller = webViewController,
        onPageFinished: (String url) {
          if (url == initialURL) {
            redirectToStripe();
          }
        },
      ),
    );
  }

  String get initialURL =>
      'data:text/html;base64,${base64Encode(Utf8Encoder().convert(kStripeHtmlPage))}';

  void redirectToStripe() {
    final redirectToCheckoutJs = '''
      var stripe = Stripe('pk_test_51HRfuDL6r6kEK5q693txJKmIcCBzlQmWOmtazwxUUBEBOcegjWezD0C1PupkU3pjCtptns4wAnIFXe1ykZPxNQrw00F47qSNCm');
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
<html>
<script src="https://js.stripe.com/v3/"></script>
<head><title>Stripe checkout</title></head>
<body>
Hello Webview
</body>
</html>
''';
