import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    delayedNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          AppAssets.instagramAnimationLogo,
          height: MediaQuery.of(context).size.height / 7,
        ),
      ),
    );
  }

  void delayedNavigation() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        FirebaseAuth.instance.currentUser == null
            ? context.pushReplacementNamed(Routes.logIn)
            : FirebaseAuth.instance.currentUser!.emailVerified == true
                ? context.pushReplacementNamed(Routes.home)
                : context.pushReplacementNamed(Routes.logIn);
      },
    );
  }
}
