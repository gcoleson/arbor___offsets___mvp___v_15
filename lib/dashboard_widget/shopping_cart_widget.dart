import 'package:flutter/material.dart';

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
