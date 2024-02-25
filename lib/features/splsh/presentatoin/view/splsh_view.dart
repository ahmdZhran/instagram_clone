import 'package:flutter/material.dart';

import '../../../../core/functions/navigator_methods.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/text_styles.dart';

class SplshView extends StatefulWidget {
  const SplshView({super.key});

  @override
  State<SplshView> createState() => _SplshViewState();
}

class _SplshViewState extends State<SplshView> {
  @override
  void initState() {
    super.initState();
  }

  void delayedNavigation(context, path) {
    Future.delayed(const Duration(seconds: 2), () {
      customReplacementNavigate(context, path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.appName,
          style: CustomTextStyles.pacifico50Style,
        ),
      ),
    );
  }
}
