import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/router/app_router.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../core/router/routes.dart';
import '../core/utils/app_them.dart';
import '../features/profile/presentation/cubit/profile_cubit.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    // Load theme from shared preferences when the app starts
    context.read<ProfileCubit>().loadTheme();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          // Set the theme based on the ProfileCubit state
          ThemeData theme = AppThemes.darkTheme; // Default to darkTheme

          if (state is ProfileThemeChanged) {
            theme = state.themeData; // Apply the dynamic theme
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: theme, // Use the theme from ProfileCubit
            onGenerateRoute: appRouter.onGenerateRoute,
            initialRoute: Routes.splashScreen,
          );
        },
      ),
    );
  }
}
