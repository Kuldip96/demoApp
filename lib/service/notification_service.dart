import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static Future<void> initialize() async {
    NotificationSettings setting =
        await FirebaseMessaging.instance.requestPermission();
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      log('Notification Initialize!');
    }
  }
}
