
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Row CustomButton(String buttonText, VoidCallback? onButtonPress) {
  return Row(
    children: [
      Spacer(flex: 21),
      Flexible(
        flex: 379,
        child: Container(
          height: 50,
          width: 379,
          child: RaisedButton(
            color: AppColors.primaryDarkGreen,
            onPressed: onButtonPress,
            child: Text(
              buttonText,
              style: TextStyle(
                  color: AppColors.white,
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