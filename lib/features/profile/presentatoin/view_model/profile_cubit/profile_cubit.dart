// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/profile/data/models/prfile_model.dart';
import 'package:meta/meta.dart';

import 'user_repositry.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepositry) : super(ProfileInfoInitial());
  final UserRepositry userRepositry;
  void getUserProfile() async {
    try {
      emit(ProfileInfoLoading());
      final userProfile = await userRepositry.getUserDetails();
      emit(ProfileInfoSuccess(userProfile: userProfile));
    } catch (e) {
      emit(ProfileInfoFailer(errMessage: e.toString()));
    }
  }

  File? userImageFile;
  void getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      userImageFile = File(pickedImage.path);
      emit(UserImageSelectedSuccess());
    } else {
      emit(UserImageSelectedFailure());
    }
  }
}
