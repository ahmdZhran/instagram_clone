import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_assets.dart';
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
      const Duration(seconds: 2),
      () {
        if (!mounted) return;
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          context.pushReplacementNamed(Routes.logIn);
        } else if (user.emailVerified) {
          context.pushReplacementNamed(Routes.mainWidget);
        } else {
          context.pushReplacementNamed(Routes.logIn);
        }
      },
    );
  }
}
