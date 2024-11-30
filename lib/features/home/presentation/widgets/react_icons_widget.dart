import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';
import '../../../../core/theme/app_them.dart';

class ReactIconsWidget extends StatelessWidget {
  const ReactIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const ThemedSvgIcon(
            assetName: AppAssets.heartIcon,
          ),
          const Gap(6),
          const Text('203'),
          const Gap(10),
          InkWell(
            onTap: () => _showCommentsBottomSheet(context),
            child: const ThemedSvgIcon(
              assetName: AppAssets.commentIcon,
            ),
          ),
          const Gap(6),
          const Text('203'),
          const Gap(10),
          const ThemedSvgIcon(
            assetName: AppAssets.shareIcon,
          ),
          const Gap(6),
          const Text('1k'),
        ],
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/airen.jpg"),
                      ),
                      title: Text('User name'),
                      subtitle: Text('This is owner comment '),
                    ),
                    const Divider(
                      color: AppColors.greyColor,
                      endIndent: 20,
                      indent: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/airen.jpg"),
                            ),
                            title: Text('User $index'),
                            subtitle: Text('This is comment $index'),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              hintText:
                                  context.translate(AppStrings.addYourComment),
                            ),
                          ),
                          const Gap(8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
