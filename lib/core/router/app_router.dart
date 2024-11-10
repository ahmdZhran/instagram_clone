import 'package:flutter/material.dart';
import 'package:instagram_clone/features/add_post/data/models/media_model.dart';
import 'package:instagram_clone/features/add_post/presentation/screens/add_description_and_upload_post_screen.dart';
import '../../features/main_widget/main_widget.dart';
import '../../features/profile/domain/entities/user_profile_entity.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/auth/presentation/screens/forget_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/presentation/screen/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.mainWidget:
        return MaterialPageRoute(
          builder: (_) => const MainWidget(),
        );
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
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case Routes.editProfileScreen:
        final userProfileData = settings.arguments as UserProfileEntity;
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(
            userProfileData: userProfileData,
          ),
        );
      case Routes.addDescriptionToPost:
        final selectedMedias = settings.arguments as List<MediaModel>?;
        return MaterialPageRoute(
          builder: (_) => AddDescriptionAndUploadPostScreen(
            selectedMedias: selectedMedias,
          ),
        );
      default:
        return null;
    }
  }
}
