import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/router/app_router.dart';
import '../core/utls/app_colors.dart';
import '../core/utls/app_strings.dart';

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: appThemData(),
        routerConfig: router,
      ),
    );
  }

  ThemeData appThemData() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.kBlackColor,
      primaryColor: AppColors.kWhiteColor,
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }
}
