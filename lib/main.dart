import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helper/secure_storage_helper.dart';
import 'core/router/app_router.dart';
import 'features/fcm_notification/fcm_services.dart';
import 'my_bloc_observer.dart';
import 'app/instagram_app.dart';
import 'core/helper/shared_pref_helper.dart';
import 'core/utils/injection_container.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefHelper = SharedPrefHelper();
  await sharedPrefHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = MyBlocObserver();
  await Future.wait([
    InjectionContainer().init(),
    getAndSaveDeviceToken(),
  ]);

  runApp(
    InstagramApp(
      appRouter: AppRouter(),
    ),
  );
}

Future<void> getAndSaveDeviceToken() async {
  try {
    final secureStorage = SecureStorageHelper();
    String? savedToken = await secureStorage.read('device_token');

    if (savedToken == null) {
      String? deviceToken = await FCMService.getDeviceToken();
      if (deviceToken != null) {
        await secureStorage.save('device_token', deviceToken);
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
