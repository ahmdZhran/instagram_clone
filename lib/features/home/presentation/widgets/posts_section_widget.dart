import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
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

              return Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
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
                              leading: const CustomCircularAvatar(
                                widthOfContainer: 40,
                                heightOfImage: 50,
                                widthOfImage: 50,
                                margin: EdgeInsets.all(2),
                                assetName:
                                    'assets/images/profile_image/post1.jpg',
                              ),
                              title: Text('userName',
                                  style: CustomTextStyle.pacifico13),
                              // subtitle: Text(timeAgo),
                              trailing: const Icon(Icons.more_horiz),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SizedBox(
                                height: 300.h,
                                // width: 250.w,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageUrl),
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
          );
        },
      ),
    );
  }
}
