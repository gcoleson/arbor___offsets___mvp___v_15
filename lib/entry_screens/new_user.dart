
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:arbor___offsets___mvp___v_15/util/CustomButton.dart';
import 'package:arbor___offsets___mvp___v_15/util/ImageTextField.dart';
import 'package:arbor___offsets___mvp___v_15/util/StandardAlert.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'login.dart';

Widget NewUserWidget(BuildContext context) {
  // Variables used to get text from textfields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function called on button pressed to register new user
  register() async {
    analytics.logTutorialComplete();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      print('Created UID:${userCredential.user!.uid}');

      //save uid in class
      databaseService.uid = userCredential.user!.uid;

      try {
        // create a new document for the user with the uid
        await databaseService.updateUserData(userdata, true);

        await databaseService.updateUserMessagesSystemType("User Created");

        await databaseService.updateUserStats();
      } catch (error) {
        print('DB error:' + error.toString());
      }

      analytics.logSignUp(signUpMethod: '');

      //go to main screen
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TabGroupOneTabBarWidget()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
        showStandardAlert(context, e.toString());
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showStandardAlert(context, e.toString());
      }
    } catch (e) {
      print(e);
      showStandardAlert(context, e.toString());
    }
  }

  analytics.logEvent(name: 'Signup');

  // UI
  return Scaffold(
    body: Container(
        child: Stack(fit: StackFit.expand, children: [
          Image.asset("assets/images/forest-sun-shadow-green-HEIC.png",
              fit: BoxFit.cover),
          Column(children: [
            Spacer(flex: 60),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                    height: 187,
                    decoration: BoxDecoration(color: AppColors.transparentScreen)),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "Arbor",
                        textAlign: TextAlign.center,
                        style: AppFonts.arborSignupTitle,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Erase your\n climate impact",
                        textAlign: TextAlign.center,
                        style: AppFonts.arborSubTitle,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 22),
            Container(
                height: 44,
                child: ImageTextField("assets/images/UserIcon.png", "Email",
                    _emailController, TextInputType.emailAddress, false)),
            Container(
                margin: EdgeInsets.only(top: 14, bottom: 22),
                height: 44,
                child: ImageTextField("assets/images/PasswordIcon.png", "Password",
                    _passwordController, TextInputType.text, true)),
            CustomButton("Join", register),
            Spacer(flex: 334),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 23,
                child: Text(
                  "Already have an account? ",
                  textAlign: TextAlign.center,
                  style: AppFonts.bodyTextWhite,
                ),
              ),
              FlatButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginWidget(context)
                      ),
                      ModalRoute.withName("/login")
                  ),
                  child: Text(
                    "Sign In",
                    style: AppFonts.bodyTextGold,
                  )),
            ]),
            Spacer(flex: 55)
          ]),
        ]))
  );
}