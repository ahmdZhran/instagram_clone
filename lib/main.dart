import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/fcm_notification/fcm_services.dart';
import 'core/router/app_router.dart';
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
  String? deviceToken = await FCMService.getDeviceToken();
  debugPrint("this is device token $deviceToken");
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    InjectionContainer().init(),
  ]);

  runApp(
    InstagramApp(
      appRouter: AppRouter(),
    ),
  );
}
