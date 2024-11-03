import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class PickImagePostWidget extends StatelessWidget {
  const PickImagePostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: 320.h,
              width: 300.w,
              child: Image.asset('assets/images/profile_image/post1.jpg')),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Recent',
                  ),
                  const Gap(10),
                  const Icon(Iconsax.arrow_down_1),
                  const Spacer(),
                  //TODO change this text to icon
                  TextButton(
                    child: const Text('Select Multiple'),
                    onPressed: () {},
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
