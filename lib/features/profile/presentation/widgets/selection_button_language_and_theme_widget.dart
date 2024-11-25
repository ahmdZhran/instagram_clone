
import 'package:flutter/material.dart';

import '../../../../core/theme/app_them.dart';
import '../../../../core/utils/app_assets.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import 'theme_and_language_bloc_builder_widget.dart';

class SelectionButtonLanguageAndThemeWidget extends StatelessWidget {
  const SelectionButtonLanguageAndThemeWidget({
    super.key,
    required ProfileCubit profileCubit,
  }) : _profileCubit = profileCubit;

  final ProfileCubit _profileCubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) {
            return ThemeAndLanguageBlocBuilderWidget(
                profileCubit: _profileCubit);
          },
        );
      },
      child: const ThemedSvgIcon(
        assetName: AppAssets.settingsIcon,
      ),
    );
  }
}
