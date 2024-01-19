import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vetmidi/controllers/auth_controller.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title ${message.notification?.title}");
  print("body ${message.notification?.body}");
  print("data ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    AuthController authController = AuthController();
    authController.fCMToken = fCMToken;
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
