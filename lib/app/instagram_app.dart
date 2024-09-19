import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/router/app_router.dart';
import '../core/router/routes.dart';
import '../core/utils/app_them.dart';
import '../features/home/presentation/screens/home_screen.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemes.lightTheme,
      onGenerateRoute: appRouter.onGenerateRoute,
      initialRoute: Routes.logIn,
      home: const HomeScreen(),
    );
  }
}
