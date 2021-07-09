
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showStandardAlert(BuildContext context, String errorMessage) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(errorMessage),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}