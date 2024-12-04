import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

class CommentsBottomSheetWidget extends StatelessWidget {
  final ScrollController scrollController;

  const CommentsBottomSheetWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
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
            subtitle: Text('This is owner comment'),
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
                    backgroundImage: AssetImage("assets/images/airen.jpg"),
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
                    hintText: context.translate(AppStrings.addYourComment),
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
  }
}
