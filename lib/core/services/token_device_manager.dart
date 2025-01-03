import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/secure_storage_helper.dart';

import 'fcm_notification_services/fcm_services.dart';

class TokenDeviceManager {
  static final TokenDeviceManager _instance = TokenDeviceManager._internal();

  TokenDeviceManager._internal();

  factory TokenDeviceManager() => _instance;

  final SecureStorageHelper _secureStorage = SecureStorageHelper();

  Future<void> initializeToken() async {
    try {
      String? savedToken = await _secureStorage.read('device_token');

      if (savedToken == null) {
        String? deviceToken = await FCMService.getDeviceToken();
        if (deviceToken != null) {
          await _secureStorage.save('device_token', deviceToken);
          debugPrint("FCM Token saved successfully: $deviceToken");
        } else {
          debugPrint("Failed to retrieve FCM Token.");
        }
      } else {
        debugPrint("FCM Token already saved: $savedToken");
      }
    } catch (e) {
      debugPrint("Error retrieving FCM Token: $e");
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read('device_token');
  }
}
