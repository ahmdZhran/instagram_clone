import 'package:flutter/material.dart';
import '../functions/show_error_message.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/utls/app_assets.dart';
import '../../../../core/utls/app_colors.dart';
import '../../../../core/utls/app_strings.dart';
import '../../../../core/utls/spacer_helper.dart';
import '../../../../core/utls/text_styles.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import 'custom_text_form_field.dart';

class SignUpFormBody extends StatelessWidget {
  const SignUpFormBody({super.key, required this.authCubit});
  final AuthCubit authCubit;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: authCubit.signUpFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                authCubit.selectedImageProfile();
              },
              child: Column(
                children: [
                  authCubit.profileImage != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(authCubit.profileImage!),
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
                authCubit.usernameController.text = username;
              },
              hintText: AppStrings.username,
            ),
            CustomTextFormField(
              hintText: AppStrings.name,
              onChanged: (name) {
                authCubit.nameController.text = name;
              },
            ),
            CustomTextFormField(
              hintText: AppStrings.bio,
              onChanged: (bio) {
                authCubit.bioController.text = bio;
              },
            ),
            CustomTextFormField(
                hintText: AppStrings.emailAddress,
                onChanged: (emialAddress) {
                  authCubit.emailAddressController.text = emialAddress;
                },
                keyboardType: TextInputType.emailAddress),
            CustomTextFormField(
              onChanged: (password) {
                authCubit.passwordController.text = password;
              },
              hintText: AppStrings.password,
              obscureText: authCubit.isObsecurePasswordText,
              suffixIcon: IconButton(
                onPressed: () {
                  authCubit.togglePasswordVisibility();
                },
                icon: Icon(
                  authCubit.isObsecurePasswordText == false
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            15.0.getVerticalSpacer(),
            CustomButton(
              onPressed: () {
                if (authCubit.signUpFormKey.currentState!.validate()) {
                  if (authCubit.profileImage != null) {
                    authCubit.createUserWithEmailAndPassword();
                  } else {
                    showErrorMessage(context, 'Please select an image');
                  }
                }
              },
              childOfCustomButton: authCubit.state is CreateUserLoading
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
