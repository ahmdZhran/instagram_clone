import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/auth/presentaion/functions/show_error_message.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/functions/image_picker_method.dart';
import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/spacer.dart';
import '../../../../core/utls/text_styles.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_text_form_field.dart';

class SignUpFormBody extends StatefulWidget {
  const SignUpFormBody({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  State<SignUpFormBody> createState() => _SignUpFormBodyState();
}

class _SignUpFormBodyState extends State<SignUpFormBody> {
  Uint8List? imageProfile;
  void selectImageProfile() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    setState(() {
      imageProfile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.authCubit.signUpFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                selectImageProfile();
              },
              child: Column(
                children: [
                  imageProfile != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(imageProfile!),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.add_a_photo,
                            size: 60,
                            color: Colors.grey[600],
                          ),
                        ),
                ],
              ),
            ),
            CustomTextFormField(
              onChanged: (username) {
                widget.authCubit.username = username;
              },
              hintText: AppStrings.username,
            ),
            CustomTextFormField(
              hintText: AppStrings.name,
              onChanged: (name) {
                widget.authCubit.name = name;
              },
            ),
            CustomTextFormField(
              hintText: AppStrings.bio,
              onChanged: (bio) {
                widget.authCubit.bio = bio;
              },
            ),
            CustomTextFormField(
                hintText: AppStrings.emailAddress,
                onChanged: (emialAddress) {
                  widget.authCubit.emailAddress = emialAddress;
                },
                keyboardType: TextInputType.emailAddress),
            CustomTextFormField(
              onChanged: (password) {
                widget.authCubit.password = password;
              },
              hintText: AppStrings.password,
              obscureText: widget.authCubit.isObsecurePasswordText,
              suffixIcon: IconButton(
                  onPressed: () {
                    widget.authCubit.togglePasswordVisibility();
                  },
                  icon: Icon(widget.authCubit.isObsecurePasswordText == false
                      ? Icons.visibility
                      : Icons.visibility_off)),
            ),
            verticalSpacer(15),
            CustomButton(
              onPressed: () {
                if (widget.authCubit.signUpFormKey.currentState!.validate()) {
                  if (imageProfile != null) {
                    widget.authCubit
                        .createUserWithEmailAndPassword(imageProfile!);
                  } else {
                    showErrorMessage(context, 'Please select an image');
                  }
                }
              },
              childOfCustomButton: widget.authCubit.state is CreateUserLoading
                  ? LottieBuilder.asset(Assets.loadingAnimtation)
                  : Text(AppStrings.signUp,
                      style: CustomTextStyles.normalTextStyle),
              color: AppColors.kBlueColor,
            )
          ],
        ),
      ),
    );
  }
}
