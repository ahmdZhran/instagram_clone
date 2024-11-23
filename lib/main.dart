import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
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
   HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    InjectionContainer().init(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  runApp(
    InstagramApp(
      appRouter: AppRouter(),
    ),
  );
}
