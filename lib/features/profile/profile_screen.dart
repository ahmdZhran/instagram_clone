import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_responsive_spacer_helper.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppResponsiveSpacerHelper.smallPaddingOnly,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Row(
                  children: [
                    Text(
                      '___ahmd.1',
                      style: CustomTextStyle.pacifico25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
