import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/router/app_router.dart';
import 'my_bloc_observer.dart';
import 'app/instagram_app.dart';
import 'core/helper/shared_pref_helper.dart';
import 'core/utils/injection_container.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize essential services first
  final sharedPrefHelper = SharedPrefHelper();
  await sharedPrefHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Start the app immediately, initialize heavy services in background
  runApp(
    InstagramApp(appRouter: AppRouter()),
  );

  // Initialize dependency injection in background to prevent blocking
  _initializeAppInBackground();
}

// Initialize heavy services in background to prevent blocking main thread
void _initializeAppInBackground() {
  Future.microtask(() async {
    try {
      // Initialize dependency injection
      await InjectionContainer().init();

      // Note: FCM and token services are currently commented out
      // Uncomment when needed:
      // await TokenDeviceManager().initializeToken();
      // FCMService.configure();
    } catch (e) {
      debugPrint('Error initializing background services: $e');
    }
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
