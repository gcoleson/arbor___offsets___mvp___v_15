import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore databaseReference = FirebaseFirestore.instance;

class ProjectData {
  static ProjectData get instance => ProjectData();

  int projectnumber; //starts at 1, zero is no project selected
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
  bool selected;
}

UserData userdata = UserData.instance;

class UserData {
  static UserData get instance => UserData();

  String firstName = 'testName';
  String lastName = 'testlast';
  int carbonOffsetMe = 20;
  int carbonOffsetFriends = 10;
  int carbonOffsetCommunity = 5;
  int timestamp = 1604201604913;
  int selectedprojectnumber = 0; //starts at 1, zero is no project selected
  bool dataLoadedFromDB = false;
}

class UserMessages {
  int messageType;
  String messageHeader;
  String messageBody;
}

class UserMessageTypes {
  static const int userMessageTypeSystem = 0;
  static const int userMessageTypeTransaction = 1;
  static const int userMessageTypeAlert = 2;
}

DatabaseService databaseService = DatabaseService();

dynamic testDBForField(DocumentSnapshot doc, String field) {
  Map<String, dynamic> test = doc.data();

  for (var entry in test.entries) {
    if (entry.key == field) {
      return entry.value;
    }
  }
  return null;
}

class DatabaseService {
  String uid;
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

  Future<void> updateUserData(UserData data, bool create) async {
    UserData test = data ?? null;
    if (test == null) {
      return null;
    }
    print('Update UID:${this.uid} db entry');

    if (create)
      return await userCollection.doc(this.uid).set({
        'firstname': data.firstName,
        'lastname': data.lastName,
        'selectedprojectnumber': data.selectedprojectnumber,
        'createtimestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
    else
      return await userCollection.doc(this.uid).set({
        'firstname': data.firstName,
        'lastname': data.lastName,
        'selectedprojectnumber': data.selectedprojectnumber,
        'lastwitetimestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
  }

  Future<void> updateUserMessagesSystemType(String messageBoday) async {
    try {
      return await userCollection
          .doc(this.uid)
          .collection('messages')
          .doc()
          .set({
        'messagetype': UserMessageTypes.userMessageTypeSystem,
        'messageheader': 'System',
        'messagebody': messageBoday,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      });
    } catch (error) {
      print('Get user data error');
      print(error.toString());
      return null;
    }
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
