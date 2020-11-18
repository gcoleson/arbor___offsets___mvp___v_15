import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  int carbonOffsetMe = 20;
  int carbonOffsetFriends = 10;
  int carbonOffsetCommunity = 5;
  int timestamp = 1604201604913;
  bool dataLoadedFromDB = false;
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

DatabaseService databaseService = DatabaseService();

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

  Future<void> updateUserData(UserData data) async {
    UserData test = data ?? null;
    if (test == null) {
      return null;
    }
    print('Create UID:${this.uid} db entry');
    return await userCollection.doc(this.uid).set({
      'firstname': data.firstName,
      'lastname': data.lastName,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
    });
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

  Future<void> addOrder(var orderList, double trees) {
    return userCollection
        .doc(this.uid)
        .collection('orders')
        .add({'date': DateTime.now(), 'trees': trees, 'items': orderList})
        .then((value) => print("Order successfulyy added"))
        .catchError((e) => print("Failed to add order: $e"));
  }

  Future<void> updateUserStats() {
    return userCollection
        .doc(this.uid)
        .set({
          'consecutiveMonths': 0,
          'totalMonths': 0,
          'totalTrees': 0,
          'treesThisMonth': 0,
          'prevMonthOfPurchase': new DateTime.utc(1997, 9, 24)
        })
        .then((value) => print("User stats successfully updated"))
        .catchError((e) => print('Failed to update user data: $e'));
  }

  CollectionReference getUserSystemMessageDB() {
    return userCollection.doc(this.uid).collection('messages');
  }
}
