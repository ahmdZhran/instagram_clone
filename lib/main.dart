import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/router/app_router.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/my_bloc_observer.dart';
import 'app/instagram_app.dart';
import 'core/helper/shared_pref_helper.dart';
import 'core/utils/injection_container.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefHelper = SharedPrefHelper();
  await sharedPrefHelper.init();
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    InjectionContainer().init(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppStrings.englishCode),
        Locale(AppStrings.arabicCode)
      ],
      path: 'assets/translations',
      startLocale: const Locale(AppStrings.englishCode),
      child: InstagramApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
