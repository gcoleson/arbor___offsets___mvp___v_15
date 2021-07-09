// @dart=2.9

import 'package:arbor___offsets___mvp___v_15/main.dart';
import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'onboard_main_screen.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

void switchPage(PageController controller, int pageNum) {
  controller.animateToPage(
    pageNum,
    duration: const Duration(milliseconds: 500),
    curve: Curves.ease,
  );
}

Widget myPage1Widget(BuildContext context) {
  analytics.logEvent(name: 'Onboarding_1');
  return Container(
    child: Stack(fit: StackFit.expand, children: [
      Image.asset("assets/images/backgroundimageGroupCity@3x.png",
          fit: BoxFit.fill),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30, left: 14, right: 14),
            child: Text(
              "All modern lifestyles have a negative climate impact.",
              textAlign: TextAlign.center,
              style: AppFonts.introScreenHeadlineText,
            )),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 60, left: 14, right: 14),
            child: Text(
              "Arbor makes it easy to eliminate yours.",
              textAlign: TextAlign.center,
              style: AppFonts.introScreenHeadlineText,
            ),
          )),
    ]),
  );
}

Widget myPage2Widget(BuildContext context) {
  analytics.logEvent(name: 'Onboarding_2');
  return Container(
    child: Stack(fit: StackFit.expand, children: [
      Image.asset("assets/images/backgroundImageGroupSprout@3x.png",
          fit: BoxFit.fill),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: AppFonts.navBarHeader,
            )),
      ), //Arbor helps you eliminate yours
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 100, left: 13, right: 13),
            child: Text(
              "Just pick a project you love ...",
              textAlign: TextAlign.center,
              style: AppFonts.introScreenHeadlineText,
            ),
          ))
    ]),
  );
}

Widget myPage3Widget(BuildContext context) {
  analytics.logEvent(name: 'Onboarding_3');
  return Container(
    child: Stack(fit: StackFit.expand, children: [
      Image.asset("assets/images/mountains-919040.png", fit: BoxFit.fill),
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
                style: AppFonts.introScreenHeadlineText),
          ))
    ]),
  );
}

Future<void> _showDialog1(BuildContext context, String errorMessage) {
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

Widget myPage4Widget(BuildContext context, PageController controller) {
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

      print('Created UID:${userCredential.user.uid}');

      //save uid in class
      databaseService.uid = userCredential.user.uid;

      try {
        // create a new document for the user with the uid
        await databaseService.updateUserData(userdata, true);

        await databaseService.updateUserMessagesSystemType("User Created");

        await databaseService.updateUserStats();
      } catch (error) {
        print('DB error:' + error.toString());
      }

      analytics.logSignUp(signUpMethod: null);

      //go to main screen
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TabGroupOneTabBarWidget()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
        _showDialog1(context, e.toString());
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _showDialog1(context, e.toString());
      }
    } catch (e) {
      print(e);
      _showDialog1(context, e.toString());
    }
  }

  analytics.logEvent(name: 'Signup');

  // UI
  return Container(
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
          child: _customTextField("assets/images/UserIcon.png", "Email",
              _emailController, TextInputType.emailAddress, false)),
      Container(
          margin: EdgeInsets.only(top: 14, bottom: 22),
          height: 44,
          child: _customTextField("assets/images/PasswordIcon.png", "Password",
              _passwordController, TextInputType.text, true)),
      customButton("Join", register),
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
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => myPage5Widget(context))),
            // { Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => TabGroupOneTabBarWidget()),
            //   );
            // }
            child: Text(
              "Sign In",
              style: AppFonts.bodyTextGold,
            )),
      ]),
      Spacer(flex: 55)
    ]),
  ]));
}

Widget myPage5Widget(BuildContext context) {
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
      databaseService.uid = userCredential.user.uid;

      await databaseService.updateUserMessagesSystemType("signin");

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TabGroupOneTabBarWidget()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _showDialog1(context, e.toString());
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        _showDialog1(context, e.toString());
      }
    } catch (e) {
      print(e);
      _showDialog1(context, e.toString());
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
                child: _customTextField("assets/images/UserIcon.png", "Email",
                    _emailController, TextInputType.emailAddress, false)),
            Container(
                margin: EdgeInsets.only(top: 14, bottom: 22),
                height: 44,
                child: _customTextField("assets/images/PasswordIcon.png",
                    "Password", _passwordController, TextInputType.text, true)),
            customButton("Sign In", signIn),
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
                      Navigator.pop(context) //switchPage(controller, 3)

                  // { Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => TabGroupOneTabBarWidget()),
                  //   );
                  // }
                  ,
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

Row customButton(String buttonText, Function onButtonPress) {
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

Row _customTextField(String imageFilePath, String customLabelText,
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
              if (val.length == 0) {
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
              _customTextField(
                  "", "email", controller, TextInputType.emailAddress, false),
              Spacer(),
              customButton(
                  "Password Reset", () => resetPassword(controller.text)),
              Spacer(),
              customButton("Cancel", () => Navigator.pop(context)),
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
