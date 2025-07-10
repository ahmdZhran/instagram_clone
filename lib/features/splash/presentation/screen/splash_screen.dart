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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Use microtask to prevent blocking main thread
    Future.microtask(() => delayedNavigation());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          AppAssets.instagramAnimationLogo,
          height: MediaQuery.of(context).size.height / 7,
          // Add frame rate optimization
          frameRate: const FrameRate(30),
          controller: _animationController,
          onLoaded: (composition) {
            _animationController.duration = composition.duration;
            _animationController.forward();
          },
        ),
      ),
    );
  }

  void delayedNavigation() async {
    // Reduce delay and add error handling
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        context.pushReplacementNamed(Routes.logIn);
      } else if (user.emailVerified) {
        context.pushReplacementNamed(Routes.mainWidget);
      } else {
        context.pushReplacementNamed(Routes.logIn);
      }
    } catch (e) {
      // Fallback to login screen if there's an error
      if (mounted) {
        context.pushReplacementNamed(Routes.logIn);
      }
    }
  }
}
