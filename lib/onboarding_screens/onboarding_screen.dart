import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:arbor___offsets___mvp___v_15/tab_group_one_tab_bar_widget/tab_group_one_tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget myPage1Widget(BuildContext context) {
  return Container(
    child: Stack(fit: StackFit.expand, children: [
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

Widget myPage2Widget(BuildContext context) {
  return Container(
    child: Stack(fit: StackFit.expand, children: [
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

Widget myPage3Widget(BuildContext context) {
  return Container(
    child: Stack(fit: StackFit.expand, children: [
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

Widget myPage4Widget(BuildContext context) {
  // Variables used to get text from textfields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function called on button pressed to register new user
  register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      print('Created UID:${userCredential.user.uid}');

      //save uid in class
      databaseService = DatabaseService(uid: userCredential.user.uid);

      // create a new document for the user with the uid
      await databaseService.updateUserData(userdata);

      await databaseService
          .updateUserMessagesSystemType("Onboarding message sent");

      //go to main screen
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TabGroupOneTabBarWidget()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // UI
  return Container(
      child: Stack(fit: StackFit.expand, children: [
    Image.asset("assets/images/forest-sun-shadow-green-HEIC.png",
        fit: BoxFit.cover),
    Column(children: [
      Spacer(flex: 65),
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
              height: 187,
              decoration:
                  BoxDecoration(color: Color.fromARGB(127, 216, 216, 216))),
          Column(
            children: [
              Container(
                child: Text(
                  "Arbor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 127, 69),
                    fontFamily: "Montserrat-SemiBold",
                    fontWeight: FontWeight.bold,
                    fontSize: 72,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Erase your\n climate impact",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 127, 69),
                    fontFamily: "Montserrat-Medium",
                    fontSize: 36,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      Spacer(flex: 375),
      Container(
          height: 44,
          child: _customTextField("assets/images/UserIcon.png", "Email",
              _emailController, TextInputType.emailAddress, false)),
      Container(
          margin: EdgeInsets.only(top: 14, bottom: 22),
          height: 44,
          child: _customTextField("assets/images/PasswordIcon.png", "Password",
              _passwordController, TextInputType.text, true)),
      _customButton("Join", register),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 21,
          child: Text(
            "Already have an account? ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Raleway-Medium",
                fontSize: 18),
          ),
        ),
        FlatButton(
            onPressed: () {},
            child: Text(
              "Sign In",
              style: TextStyle(
                  color: Color.fromARGB(255, 250, 195, 21),
                  fontSize: 18,
                  fontFamily: "Raleway-Medium"),
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

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      //save uid in class
      databaseService = DatabaseService(uid: userCredential.user.uid);

      await databaseService.updateUserMessagesSystemType("signin");

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TabGroupOneTabBarWidget()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
      }
    } catch (e) {
      print(e);
    }
  }

  return Container(
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: AssetImage("assets/images/WelcomeBackScreen.png"),
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            Spacer(flex: 68),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                    height: 159,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(127, 216, 216, 216))),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "Arbor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 65, 127, 69),
                          fontFamily: "Montserrat-SemiBold",
                          fontWeight: FontWeight.bold,
                          fontSize: 72,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Welcome Back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 65, 127, 69),
                          fontFamily: "Montserrat-Medium",
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(flex: 47),
            Container(
                height: 44,
                child: _customTextField("assets/images/UserIcon.png", "Email",
                    _emailController, TextInputType.emailAddress, false)),
            Container(
                margin: EdgeInsets.only(top: 14, bottom: 22),
                height: 44,
                child: _customTextField("assets/images/PasswordIcon.png",
                    "Password", _passwordController, TextInputType.text, true)),
            _customButton("Sign In", signIn),
            FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 250, 195, 21),
                      fontSize: 18,
                      fontFamily: "Raleway-Medium"),
                )),
            Spacer(flex: 334),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 21,
                child: Text(
                  "Need an account? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Raleway-Medium",
                      fontSize: 18),
                ),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TabGroupOneTabBarWidget()),
                    );
                  },
                  child: Text(
                    "Join",
                    style: TextStyle(
                        color: Color.fromARGB(255, 250, 195, 21),
                        fontSize: 18,
                        fontFamily: "Raleway-Medium"),
                  )),
            ]),
            Spacer(flex: 47)
          ],
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
            color: Color.fromARGB(255, 65, 127, 69),
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
              fillColor: Colors.white,
              labelText: customLabelText,
              border: new OutlineInputBorder(
                //borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
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
          ))),
      Spacer(flex: 14)
    ],
  );
}
