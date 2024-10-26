import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
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
    profileCubit = ProfileCubit.getInstance();
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
            // Show a loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Updating profile...")),
            );
          } else if (state is ProfileUpdateSuccess) {
            // Show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
            Navigator.pop(context); // Go back to the previous screen
          } else if (state is ProfileUpdateFailure) {
            // Show an error message
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
                        backgroundImage: profileImage != null
                            ? MemoryImage(profileImage!)
                            : NetworkImage(
                                widget.userProfileData.profileImageUrl,
                              ) as ImageProvider,
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

  void _saveProfileChanges() async {
    try {
      String? profileImageUrl = widget.userProfileData.profileImageUrl;

      // If a new image is selected, upload it
      if (profileImage != null) {
        profileImageUrl = await StorageService.uploadProfileImage(
            profileImage!, widget.userProfileData.uid);
      }
      final updatedProfile = UserProfileEntity(
        name: name ?? widget.userProfileData.name,
        username: username ?? widget.userProfileData.username,
        bio: bio ?? widget.userProfileData.bio,
        profileImageUrl: profileImageUrl,
        uid: widget.userProfileData.uid,
      );
      profileCubit.updatedUserData(updatedProfile);
    } catch (e) {
      // Handle any errors, e.g., show a Snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }
}

class StorageService {
  static Future<String> uploadProfileImage(
      Uint8List imageData, String userId) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profileImages').child(userId);
      final uploadTask = await storageRef.putData(imageData);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
