import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/home/presentation/screens/home_screen.dart';
import 'package:instagram_clone/features/main_widget/main_widget.dart';
import 'package:instagram_clone/features/notifications/notifications_screen.dart';

import '../../../main.dart';

class FCMService {
  static Future<String?> getDeviceToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      await messaging.requestPermission();

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

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'message is Null');
  }

  static Future<void> handleMessage(RemoteMessage message) async {
    final String? screen = message.data['screen'];

    if (screen == 'home') {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else if (screen == 'notification') {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const NotificationsScreen(),
        ),
      );
    } else {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const MainWidget(),
        ),
      );
    }
  }

  static void configure() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
