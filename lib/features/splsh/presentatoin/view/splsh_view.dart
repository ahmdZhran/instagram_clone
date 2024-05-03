import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/functions/navigator_methods.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/router/route_constants.dart';
import '../../../../core/utls/app_assets.dart';

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
            ? context.customReplacementNavigate(RouteConstants.signInRoute)
            : context
                .customReplacementNavigate(RouteConstants.bottomNavBarRoute);
      },
    );
  }
}
