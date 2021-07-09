
import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:arbor___offsets___mvp___v_15/util/CustomButton.dart';
import 'package:arbor___offsets___mvp___v_15/util/ImageTextField.dart';
import 'package:arbor___offsets___mvp___v_15/util/StandardAlert.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';

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

  return Scaffold(
    //resizeToAvoidBottomPadding: false,
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
                Spacer(flex: 75),
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
                SizedBox(height: 47),
                Container(
                    height: 44,
                    child: ImageTextField("assets/images/UserIcon.png", "Email",
                        _emailController, TextInputType.emailAddress, false)),
                Container(
                    margin: EdgeInsets.only(top: 14, bottom: 22),
                    height: 44,
                    child: ImageTextField("assets/images/PasswordIcon.png",
                        "Password", _passwordController, TextInputType.text, true)),
                CustomButton("Sign In", signIn),
                FlatButton(
                    onPressed: () {
                      passwordResetDialog(context, _passwirdResetController);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppFonts.bodyTextGold,
                    )),
                Spacer(flex: 334),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    height: 21,
                    child: Text(
                      "Need an account? ",
                      textAlign: TextAlign.center,
                      style: AppFonts.bodyTextWhite,
                    ),
                  ),
                  FlatButton(
                      onPressed: () =>
                          Navigator.pop(context),
                      child: Text(
                        "Join",
                        style: AppFonts.bodyTextGold,
                      )),
                ]),
                Spacer(flex: 47)
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
