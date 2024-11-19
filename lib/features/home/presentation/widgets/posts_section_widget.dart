import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'custom_circle_avatar.dart';
import 'react_icons_widget.dart';

class PostsSectionWidget extends StatelessWidget {
  const PostsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 400.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.greyColor.withOpacity(0.5),
                          AppColors.greyColor.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          horizontalTitleGap: 10,
                          dense: true,
                          leading: const CustomCircularAvatar(
                            widthOfContainer: 40,
                            heightOfImage: 50,
                            widthOfImage: 50,
                            margin: EdgeInsets.all(2),
                            assetName: 'assets/images/profile_image/post1.jpg',
                          ),
                          title:
                              Text('ahmd1', style: CustomTextStyle.pacifico13),
                          subtitle: const Text('1 min'),
                          trailing: const Icon(Icons.more_horiz),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 300.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 7.0,
                              ),
                            ],
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/profile_image/profile.png",
                              ),
                            ),
                          ),
                        ),
                        const ReactIconsWidget()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
