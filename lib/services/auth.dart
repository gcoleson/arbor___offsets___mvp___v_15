import 'package:arbor___offsets___mvp___v_15/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

AuthService authService = AuthService.instance;

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

class AuthService {
  static AuthService get instance => AuthService();

/*   // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
 */

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  /* Future registerWithEmailAndPassword(UserData userdata, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: userdata.emailAddress, 
        password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid, data: userdata ).updateUserData();
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
   */

  Future<String> registerWithEmailAndPassword(
      UserData userdata, String password) async {
    try {
      print(userdata);
      print(password);

      var result;

      result = await _auth.createUserWithEmailAndPassword(
          email: userdata.emailAddress, password: password);

      databaseService = DatabaseService(uid: result.user.uid);

      // create a new document for the user with the uid
      await databaseService.updateUserData(userdata);

      await databaseService
          .updateUserMessagesSystemType("Onboarding message sent");

      return result.user.uid;
    } catch (error) {
      print('register error');
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
