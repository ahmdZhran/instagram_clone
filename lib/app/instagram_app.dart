import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/router/app_router.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../core/languages/app_localization_setup.dart';
import '../core/languages/lang_code.dart';
import '../core/router/routes.dart';
import '../core/theme/app_them.dart';
import '../features/profile/presentation/cubits/profile_cubit.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: ProfileCubit.getInstance()..loadTheme(),
        builder: (context, state) {
          ThemeData theme = AppThemes.darkTheme;
          if (state is ProfileThemeChanged) {
            theme = state.themeData;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            locale: const Locale(LangCode.englishCode),
            theme: theme,
            onGenerateRoute: appRouter.onGenerateRoute,
            initialRoute: Routes.splashScreen,
          );
        },
      ),
    );
  }
}
