import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SearchForUserWidget extends StatefulWidget {
  const SearchForUserWidget({
    super.key,
  });

  @override
  State<SearchForUserWidget> createState() => _SearchForUserWidgetState();
}

class _SearchForUserWidgetState extends State<SearchForUserWidget> {
  String? username;
  QuerySnapshot<Map<String, dynamic>>? searchResults;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomTextFormField(
            fillColor: context.isDart ? null : AppColors.moreLightGrey,
            onChanged: (value) {
              setState(() {
                username = value;
              });
              _searchUser();
            },
            hintText: 'Search for user',
            prefixIcon: const Icon(
              Iconsax.search_normal,
              color: AppColors.greyColor,
            ),
            controller: null,
          ),
          const Gap(20),
          if (searchResults != null && searchResults!.docs.isNotEmpty)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchResults!.docs.length,
                itemBuilder: (context, index) {
                  var userData = searchResults!.docs[index].data();
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    horizontalTitleGap: 5,
                    leading: ClipOval(
                      child: Image.network(
                        userData['profile_image'],
                        fit: BoxFit.contain,
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                    title: Text(userData['user_name']),
                  );
                },
              ),
            )
          else if (searchResults != null && searchResults!.docs.isEmpty)
            const Text("No users found"),
        ],
      ),
    );
  }

  Future<void> _searchUser() async {
    if (username == null || username!.isEmpty) {
      setState(() {
        searchResults = null;
      });
      return;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("user_name", isEqualTo: username)
        .get();

    setState(() {
      searchResults = querySnapshot;
    });
  }
}
