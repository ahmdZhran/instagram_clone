import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import '../widgets/custom_circle_avatar.dart';
import '../widgets/custom_sliver_app_bar_widget.dart';
import '../widgets/react_icons_widget.dart';
import '../widgets/story_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          clipBehavior: Clip.none,
          physics: BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBarWidget(),
            StorySectionWidget(),
            PostsSectionWidget()
          ],
        ),
      ),
    );
  }
}

class PostsSectionWidget extends StatelessWidget {
  const PostsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GlassmorphicContainer(
                width: double.infinity,
                height: 420.0.h,
                borderRadius: 25.0,
                linearGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.greyColor.withOpacity(0.4),
                    AppColors.greyColor.withOpacity(0.4),
                  ],
                ),
                border: 0,
                blur: 100,
                borderGradient: const LinearGradient(
                  colors: [Colors.pink, Colors.teal],
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
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
                          title: Text('ahmed__21',
                              style: CustomTextStyle.pacifico13),
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
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
