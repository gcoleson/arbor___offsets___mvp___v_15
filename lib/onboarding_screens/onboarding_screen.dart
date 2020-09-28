import 'package:flutter/material.dart';

Widget MyPage1Widget(BuildContext context) {
  return Container(
    child: Stack(children: [
      Image.asset("assets/images/bridge-1850679.png", fit: BoxFit.cover),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(
              "All modern lifestyles have a negative climate impact",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            )),
      ), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 100, left: 10, right: 10),
            child: Text(
              "Arbor makes it easy to eliminate yours",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
          )),
    ]),
  );
}

Widget MyPage2Widget(BuildContext context) {
  return Container(
    child: Stack(children: [
      Image.asset("assets/images/plant-5310423.png", fit: BoxFit.cover),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            )),
      ), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 100, left: 10, right: 10),
            child: Text(
              "Just pick a project you love ...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
          ))
    ]),
  );
}

Widget MyPage3Widget(BuildContext context) {
  return Container(
    child: Stack(children: [
      Image.asset("assets/images/mountains-919040.png", fit: BoxFit.cover),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(""),
          )), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 100, left: 10, right: 10),
            child: Text(
              "... and eliminate your impact with the tap of a button!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
          ))
    ]),
  );
}

Widget MyPage4Widget(BuildContext context) {
  return Container(
      child: Stack(children: [
    Image.asset("assets/images/forest-sun-shadow-green-HEIC.png",
        fit: BoxFit.cover),
    Column(children: [
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 100, left: 10, right: 10),
            child: Text(
              "Arbor",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
          )),
      Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Erase Your Climate Impact",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
          )), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Text(
                "New Email ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              Align(
                  child: Container(
                      width: 200,
                      child: TextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          icon: new Icon(Icons.mail, color: Colors.grey),
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 98, 0, 238),
                          fontFamily: "HK Grotesk",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ))),
            ],
          ))
    ]),
  ]));
}
