
import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:arbor___offsets___mvp___v_15/util/CustomButton.dart';
import 'package:arbor___offsets___mvp___v_15/util/ImageTextField.dart';
import 'package:arbor___offsets___mvp___v_15/util/OutlinedText.dart';
import 'package:arbor___offsets___mvp___v_15/util/StandardAlert.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';

import 'new_user.dart';

Widget LoginWidget(BuildContext context) {
  // Variables used to get text from textfields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwirdResetController = TextEditingController();

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      //save uid in class
      databaseService.uid = userCredential.user!.uid;

      await databaseService.updateUserMessagesSystemType("signin");

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TabGroupOneTabBarWidget()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showStandardAlert(context, e.toString());
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        showStandardAlert(context, e.toString());
      }
    } catch (e) {
      print(e);
      showStandardAlert(context, e.toString());
    }
  }

  analytics.logEvent(name: 'Signin');

  var textStyle = AppFonts.introScreenHeadlineText
      .copyWith(shadows: outlinedText(strokeColor: Colors.black));

  return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage("assets/images/WelcomeBackScreen.png"),
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                        height: 159,
                        decoration:
                        BoxDecoration(color: AppColors.transparentScreen)),
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
                            "Welcome Back",
                            textAlign: TextAlign.center,
                            style: AppFonts.arborSubTitle,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Spacer(flex: 1),
                Container(
                    child: ImageTextField("assets/images/UserIcon.png", "Email",
                        _emailController, TextInputType.emailAddress, false)),
                Container(
                    margin: EdgeInsets.only(top: 14, bottom: 22),
                    child: ImageTextField("assets/images/PasswordIcon.png",
                        "Password", _passwordController, TextInputType.text, true)),
                Spacer(flex: 4),
                CustomButton("Sign In", signIn),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () {
                          passwordResetDialog(context, _passwirdResetController);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: AppFonts.bodyTextGold,
                        )),
                    Text("/", style: textStyle),
                    FlatButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewUserWidget(context)
                            ),
                            ModalRoute.withName("/new_user")),
                        child: Text(
                          "Join",
                          style: AppFonts.bodyTextGold,
                        ))
                  ]
                ),
              ],
            )
             ],
        ),
      ));
}


Future passwordResetDialog(
    BuildContext context, TextEditingController controller) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              Text(
                "Type your email",
                style: AppFonts.arborSubTitle,
              ),
              Spacer(),
              ImageTextField(
                  "", "email", controller, TextInputType.emailAddress, false),
              Spacer(),
              CustomButton(
                  "Password Reset", () => resetPassword(controller.text)),
              Spacer(),
              CustomButton("Cancel", () => Navigator.pop(context)),
              Spacer(),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> resetPassword(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
