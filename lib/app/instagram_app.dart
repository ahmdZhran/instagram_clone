import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/cubits/profile_cubit/profile_cubit.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_them.dart';
import '../core/utils/app_strings.dart';
import '../core/languages/app_localization_setup.dart';
import '../core/router/routes.dart';
import '../features/profile/presentation/cubits/settings/settings_cubit.dart';
import '../main.dart';

class InstagramApp extends StatefulWidget {
  const InstagramApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<InstagramApp> createState() => _InstagramAppState();
}

class _InstagramAppState extends State<InstagramApp> {
  final settingsCubit = SettingsCubit.getInstance()
    ..loadTheme()
    ..loadLanguage();

  //TODO put this in a suitble place
  final ProfileCubit profileCubit = ProfileCubit.getInstance()
    ..getUserData(userId: FirebaseAuth.instance.currentUser?.uid ?? '');

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: settingsCubit,
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            locale: Locale(settingsCubit.currentLangCode),
            theme: settingsCubit.isDark
                ? AppThemes.darkTheme
                : AppThemes.lightTheme,
            onGenerateRoute: widget.appRouter.onGenerateRoute,
            initialRoute: Routes.splashScreen,
          );
        },
      ),
    );
  }
}
