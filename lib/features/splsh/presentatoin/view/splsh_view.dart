import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_assets.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/functions/navigator_methods.dart';

class SplshView extends StatefulWidget {
  const SplshView({super.key});

  @override
  State<SplshView> createState() => _SplshViewState();
}

class _SplshViewState extends State<SplshView> {
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
          Assets.instagramAnimationLogo,
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
            ? customNavigator(context, '/signUpView')
            : customNavigator(context, '/homeView');
      },
    );
  }
}
