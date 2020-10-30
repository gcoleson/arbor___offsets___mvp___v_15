import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arbor___offsets___mvp___v_15/services/auth.dart';

FirebaseFirestore databaseReference = FirebaseFirestore.instance;

UserData userdata = UserData.instance;

class ProjectData {
  static ProjectData get instance => ProjectData();

  String brief;
  String description;
  String imagemain;
  String image1;
  String image2;
  String image3;
  String image4;
  String location;
  GeoPoint maplocal;
  int percent;
  String sponsor;
  String sponsorlogo;
  String title;
}

class UserData {
  static UserData get instance => UserData();

  String firstName = 'testName';
  String lastName = 'testlast';
  String addressStreet = "teststreet";
  String addressState = 'teststate';
  String addressZipcode = 'testzip';
  String phoneNumberOne = 'testphone1';
  String phoneNumberTwo = 'testphone2';
  String phoneNumberThree = 'testphone3';
  String emailAddress = 'test@test.com';
  int carbonOffsetMe = 20;
  int carbonOffsetFriends = 10;
  int carbonOffsetCommunity = 5;
}

class UserMessages {
  int messageType;
  String messageHeader;
  String messageBody;
}

class UserMessageTypes {
  static const int userMessageTypeSystem = 0;
  static const int userMessageTypeTransaction = 0;
  static const int userMessageTypeAlert = 0;
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(UserData data) async {
    return await userCollection.doc(this.uid).set({
      'firstName': data.firstName,
      'lastName': data.lastName,
      'addressStreet': data.addressStreet,
      'addressState': data.addressState,
      'addressZipcode': data.addressZipcode,
      'phoneNumberOne': data.phoneNumberOne,
      'phoneNumberTwo': data.phoneNumberTwo,
      'phoneNumberThree': data.phoneNumberOne,
      'emailAddress': data.emailAddress,
      'carbonoffsetme': data.carbonOffsetMe,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
    });
  }

  Future<void> updateUserMessagesSystemType(String messageBoday) async {
    return await userCollection.doc(this.uid).collection('messages').doc().set({
      'messagetype': UserMessageTypes.userMessageTypeSystem,
      'messageheader': 'System',
      'messagebody': messageBoday,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
    });
  }

  Future<void> updateUserMessagesTransferType(String messageBoday) async {
    return await userCollection.doc(this.uid).collection('messages').doc().set({
      'messagetype': UserMessageTypes.userMessageTypeTransaction,
      'messageheader': 'Transfer',
      'messagebody': messageBoday,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
    });
  }

  Future<void> updateUserMessagesAlertType(
      String uid, String messageBoday) async {
    return await userCollection.doc(this.uid).collection('messages').doc().set({
      'messagetype': UserMessageTypes.userMessageTypeAlert,
      'messageheader': 'Alert',
      'messagebody': messageBoday,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
    });
  }

  CollectionReference getUserSystemMessageDB() {
    return userCollection.doc(this.uid).collection('messages');
  }
}
