import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/router/app_router.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../core/router/routes.dart';
import '../core/utils/app_them.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppThemes.lightTheme,
        onGenerateRoute: appRouter.onGenerateRoute,
        initialRoute: Routes.logIn,
      ),
    );
  }
}
