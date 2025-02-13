import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificaitonsManager {
  PushNotificaitonsManager._();

  factory PushNotificaitonsManager() => _instance;

  static final PushNotificaitonsManager _instance =
      PushNotificaitonsManager._();

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      //_firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.requestPermission();

      //_firebaseMessaging.configure();

      String? token = await _firebaseMessaging.getToken();

      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}
