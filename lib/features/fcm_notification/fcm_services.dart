import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  static Future<String?> getDeviceToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request permissions if needed
      await messaging.requestPermission();

      // Retrieve the FCM token
      String? token = await messaging.getToken();
      if (token != null) {
        debugPrint("FCM Token: $token");
      }
      return token;
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
      return null;
    }
  }
}
