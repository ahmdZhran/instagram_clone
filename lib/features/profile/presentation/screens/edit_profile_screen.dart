import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/utils_messages.dart';
import '../../../../core/services/firebase_storage_service.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../../../core/widgets/custom_out_line_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userProfileData});
  final UserProfileEntity userProfileData;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? name;
  String? username;
  String? bio;
  Uint8List? profileImage;
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = ProfileCubit.getInstance(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: isNotEmpty ? _saveProfileChanges : null,
            icon: Icon(
              size: 30,
              Icons.check,
              color: isNotEmpty
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(.4),
            ),
          ),
        ],
        title: Text(
          context.translate(AppStrings.editProfile),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        bloc: profileCubit,
        listener: (context, state) {
          if (state is ProfileUpdateLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Updating profile...")),
            );
          } else if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
            Navigator.pop(context);
          } else if (state is ProfileUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200], // Placeholder color
                        child: profileImage != null
                            ? ClipOval(
                                child: Image.memory(
                                  profileImage!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    widget.userProfileData.profileImageUrl,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) =>
                                    ClipOval(
                                  child: Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final selectedImage =
                            await profileCubit.selectedImageProfile();
                        if (selectedImage != null) {
                          setState(() {
                            profileImage = selectedImage;
                          });
                        }
                      },
                      child: Text(
                        context.translate(AppStrings.changePhoto),
                        style: CustomTextStyle.pacifico18,
                      ),
                    ),
                    CustomOutlineTextFormFieldWidget(
                      hintText: widget.userProfileData.name,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const Gap(20),
                    CustomOutlineTextFormFieldWidget(
                      hintText: widget.userProfileData.username,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    const Gap(20),
                    CustomOutlineTextFormFieldWidget(
                      hintText: widget.userProfileData.bio,
                      onChanged: (value) {
                        setState(() {
                          bio = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool get isNotEmpty {
    return (name?.isNotEmpty ?? false) ||
        (username?.isNotEmpty ?? false) ||
        (bio?.isNotEmpty ?? false) ||
        (profileImage?.isNotEmpty ?? false);
  }

  Future<void> _saveProfileChanges() async {
    try {
      String? profileImageUrl = widget.userProfileData.profileImageUrl;

      if (profileImage != null) {
        profileImageUrl =
            await FirebaseStorageService.uploadImagesToFireStorage(
                profileImage!, widget.userProfileData.uid, "profileImages");
      }
      final updatedProfile = UserProfileEntity(
        name: name ?? widget.userProfileData.name,
        username: username ?? widget.userProfileData.username,
        bio: bio ?? widget.userProfileData.bio,
        profileImageUrl: profileImageUrl,
        uid: widget.userProfileData.uid,
        //TOdO don't send this when you are updating the profile
        followers: [],
        following: [],
      );
      profileCubit.updatedUserData(updatedProfile);
    } catch (e) {
      if (mounted) {
        UtilsMessages.showToastErrorBottom(context,
            message: "Can't update your profile");
      }
    }
  }
}
