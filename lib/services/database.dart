import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore databaseReference = FirebaseFirestore.instance;

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

UserData userdata = UserData.instance;

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
  int timestamp = 1604201604913;
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

  Stream<DocumentSnapshot> getUserData() {
    if (this.uid == null) return null;

    try {
      return userCollection.doc(this.uid).snapshots();
    } catch (error) {
      print('Get user data error');
      print(error.toString());
      return null;
    }
  }

  Future<void> updateUserData(UserData data) async {
    UserData test = data ?? null;
    if (test == null) {
      return null;
    }
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
