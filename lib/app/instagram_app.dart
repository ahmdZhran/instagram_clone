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
    final profileCubit = ProfileCubit.getInstance();
    profileCubit.loadTheme();
    profileCubit.loadLanguage();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          bloc: profileCubit,
          builder: (context, state) {
            ThemeData theme = AppThemes.darkTheme;
            Locale locale = context.locale;
            if (state is ProfileThemeChanged) {
              theme = state.themeData;
            }
            if (state is ProfileLanguageChanged) {
              locale = state.locale;
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: locale,
              theme: theme,
              onGenerateRoute: appRouter.onGenerateRoute,
              initialRoute: Routes.splashScreen,
            );
          },
        );
      },
    );
  }
}
