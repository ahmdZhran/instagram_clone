import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/models/user_profile_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';

class CommentsBottomSheetWidget extends StatefulWidget {
  final ScrollController scrollController;
  final String username;
  final String profileImage;
  final String description;
  const CommentsBottomSheetWidget({
    super.key,
    required this.scrollController,
    required this.username,
    required this.profileImage,
    required this.description,
  });

  @override
  State<CommentsBottomSheetWidget> createState() =>
      _CommentsBottomSheetWidgetState();
}

class _CommentsBottomSheetWidgetState extends State<CommentsBottomSheetWidget> {
  UserProfileEntity? _userProfile;
//TODO implement this
  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() {
    setState(() {
      _userProfile = UserProfileManager().userProfile;
    });
  }

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
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.profileImage),
            ),
            title: Text(widget.username),
            subtitle: Text(widget.description),
          ),
          const Divider(
            color: AppColors.greyColor,
            endIndent: 20,
            indent: 20,
          ),
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
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
                CircleAvatar(
                  backgroundImage: _userProfile?.profileImageUrl != null
                      ? CachedNetworkImageProvider(
                          _userProfile!.profileImageUrl,
                        )
                      : const AssetImage(
                          'assets/images/place_holder.png',
                        ),
                ),
                const Gap(5),
                Expanded(
                  child: CustomTextFormField(
                    hintText: context.translate(AppStrings.addYourComment),
                  ),
                ),
                const Gap(8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // TodO send comment to firebase firestore 
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
