import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/features/auth/presentaion/views/sign_up.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const SignUpView(),
    );
  }
}
