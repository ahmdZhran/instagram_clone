import 'package:flutter/material.dart';
import 'package:instagram_clone/features/auth/presentatoins/screens/sign_in_screen.dart';
import 'package:instagram_clone/features/auth/presentatoins/screens/sign_up.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logIn:
        return MaterialPageRoute(
          builder: (_) => const LogInScreen(),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
