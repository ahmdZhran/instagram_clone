import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_short_messages_for_time_ago.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'circle_profile_image_widget.dart';
import 'react_icons_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsSectionWidget extends StatelessWidget {
  const PostsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              final imageUrl = doc['imageUrl'];
              final username = doc['user_name'];
              final userProfileImage = doc['user_profile_image'];
              final description = doc['description'];
              final publishedAt = doc['timesTamp'];
              final postTime = (publishedAt as Timestamp).toDate();
              timeago.setLocaleMessages('custom', CustomShortMessages());
              final timeAgo = timeago.format(postTime, locale: 'custom');
              return Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 420.0.h,
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
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              horizontalTitleGap: 10,
                              dense: true,
                              leading: CircleProfileImageWidget(
                                  userProfileImage: userProfileImage),
                              title: Text(username,
                                  style: CustomTextStyle.pacifico13),
                              subtitle: Text(timeAgo),
                              trailing: const Icon(Icons.more_horiz),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SizedBox(
                                width: 300.w,
                                height: 300.h,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageUrl),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                      overflow: TextOverflow.ellipsis,
                                      description,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            const ReactIconsWidget()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
