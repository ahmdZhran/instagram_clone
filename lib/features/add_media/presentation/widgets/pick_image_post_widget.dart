import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/features/add_media/presentation/widgets/picked_image_interaction_widget.dart';

class PickImagePostWidget extends StatefulWidget {
  const PickImagePostWidget({super.key});

  @override
  PickImagePostWidgetState createState() => PickImagePostWidgetState();
}

class PickImagePostWidgetState extends State<PickImagePostWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PickerImageInteractionWidget(),
          SizedBox(
            height: 60.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text('Recent', style: CustomTextStyle.pacifico20),
                  const Gap(10),
                  const Icon(Iconsax.arrow_down_1),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.multiple_stop),
                  ),
                  IconButton(
                    enableFeedback: true,
                    icon: const Icon(Icons.camera),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
