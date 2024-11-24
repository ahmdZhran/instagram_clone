import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SearchForUserWidget extends StatelessWidget {
  const SearchForUserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          fillColor: context.isDart ? null : AppColors.moreLightGrey,
          onChanged: (p0) {},
          hintText: 'search for user',
          prefixIcon: const Icon(
            Iconsax.search_normal,
            color: AppColors.greyColor,
          ),
          controller: null,
        ),
        const Gap(20),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          horizontalTitleGap: 5,
          leading: ClipOval(
            child: Image.network(
              'https://i.pinimg.com/736x/61/1a/f6/611af643295ec21d99e1fbd21788e2f9.jpg',
              fit: BoxFit.contain,
              width: 50.w,
              height: 50.h,
            ),
          ),
          title: const Text('ahmd1'),
        )
      ],
    );
  }
}
