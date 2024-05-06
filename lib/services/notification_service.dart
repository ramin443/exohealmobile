import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


class NotificationService {
  final firebaseMessaging = FirebaseMessaging.instance;
  bool newChat = false;

  final remoteConfig = FirebaseRemoteConfig.instance;


  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print("token is here $fcmToken");
    initPushNotifications();
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroudMessage);
  }

  Future<void> handleBackgroudMessage(RemoteMessage message) async {
    print("This ios solely for testing");
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Payload: ${message.data}");
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print(message.notification?.body);
    if (message.notification!.body!.contains("Impuls mit dir geteilt")) {
    /*  navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const Authenticate(
                currentHomeScreenState: 1,
              )),
              (route) => false);*/
    } else if (message.notification!.title == "Neue Nachricht") {
      if (newChat) {
      /*  navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ChatV2Screen()),
                (route) => false);*/
      } else {
      /*  navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ChatV2Screen()),
                (route) => false);*/
      }
    }
  }
}
