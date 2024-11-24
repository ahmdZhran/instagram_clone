import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';

import '../widgets/search_for_user_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
        child: Column(
          children: [
            SearchForUserWidget(),
          ],
        ),
      )),
    );
  }
}
