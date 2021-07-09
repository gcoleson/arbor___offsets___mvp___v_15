
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Row ImageTextField(String imageFilePath, String customLabelText,
    TextEditingController controller, TextInputType inputType, bool isObscure) {
  return Row(
    children: [
      Spacer(flex: 17),
      Flexible(flex: 38, child: Image.asset(imageFilePath, fit: BoxFit.fill)),
      Flexible(flex: 18, child: Container()),
      Flexible(
        flex: 327,
        child: Container(
          child: TextFormField(
            obscureText: isObscure,
            controller: controller,
            decoration: new InputDecoration(
              filled: true,
              labelStyle: TextStyle(fontSize: 20.0, color: AppColors.primaryDarkGreen),
              fillColor: Colors.white.withOpacity(.6),
              labelText: customLabelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color: AppColors.borderGrey,
                  width: 2.0,
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color: AppColors.primaryDarkGreen,
                  width: 3.0,
                ),
              ),
            ),
            validator: (val) {
              if (val?.length == 0) {
                return "Field cannot be empty";
              } else {
                return null;
              }
            },
            keyboardType: inputType,
            style: new TextStyle(
              fontFamily: "HK Grotesk",
            ),
          ),
        ),
      ),
      Spacer(flex: 14)
    ],
  );
}