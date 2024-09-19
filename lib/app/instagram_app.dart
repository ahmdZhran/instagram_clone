import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../core/utils/app_them.dart';
import '../main.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemes.lightTheme,
      home: const HomeScreen(),
    );
  }
}
