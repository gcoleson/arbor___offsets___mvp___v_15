import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/values.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

class arborExplanation extends StatefulWidget {
  @override
  _arborExplanationState createState() => _arborExplanationState();
}

class _arborExplanationState extends State<arborExplanation> {
  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'how_to');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "How Arbor Works",
          textAlign: TextAlign.center,
          style: AppFonts.navBarHeader,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 65, 127, 69),
      ),
      body: step(context),
    );
  }
}

Widget step(BuildContext context) {
  return Scrollbar(
    child: ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 17,
        ),
        generateItem(
            "Select a Project on the Projects List",
            "Arbor has hand-selected these projects for their climate impact. Pick which you love best.",
            "assets/images/icons8PhotoEditor100.png"),
        Container(
          height: 45,
        ),
        generateItem(
            "Select a Harm You Want To Undo",
            "Certain activities harm the climate by releasing carbon. Arbor has calculated the carbon generated from some common activities. The price shown is the cost of enabling your project to remove that amount of carbon.",
            "assets/images/How-to-harm.png"),
        Container(
          height: 45,
        ),
        generateItem(
            "Checkout and Fund Your Project",
            "When you pay to eliminate the climate impact of an activity, Arbor purchases that amount of carbon removal from your project. ",
            "assets/images/icons8-checkout-100.png"),
        Container(
          height: 45,
        ),
        generateItem(
            "See Your Impact",
            "Your impact will be shown at the top of your dashboard.",
            "assets/images/icons8ControlPanel64.png"),
        Container(
          height: 45,
        ),
        _customButton("Got It", () => Navigator.pop(context))
      ],
    ),
  );
}

Widget generateItem(String title, String description, String path) {
  return Container(
    child: Row(
      children: [
        Container(width: 60, child: Container(child: Image.asset(path))),
        Container(
          width: 27,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFonts.projectLabelHeadline,
                textAlign: TextAlign.start,
              ),
              Container(
                height: 8,
              ),
              Text(
                description,
                style: AppFonts.projectLabelSubhead,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
        Container(
          width: 13,
        )
      ],
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
            shape: RoundedRectangleBorder(borderRadius: Radii.k8pxRadius),
            color: AppColors.primaryDarkGreen,
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
