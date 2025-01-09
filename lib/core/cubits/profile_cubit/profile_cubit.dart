import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/image_service.dart';
import '../../models/user_profile_manager.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import '../../../features/profile/domain/entities/user_profile_entity.dart';
import '../../../features/profile/profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository, this.userId) : super(ProfileInitial()) {
    _pickerImageService = ImagePickerService();
    getUserData(userId: userId);
  }

  final ProfileRepository _profileRepository;
  final String userId;
  ImagePickerService? _pickerImageService;
  UserProfileEntity? userProfileData;
  Uint8List? profileImage;

  UserProfileEntity get getUserProfileData => userProfileData!;
  Uint8List get getProfileImage => profileImage!;

  Future<void> getUserData({required String userId}) async {
    try {
      emit(ProfileLoading());
      final userData = await _profileRepository.getProfileData(userId);
      userProfileData = userData;

      UserProfileManager().updateUserProfile(userData);
      emit(ProfileSuccess());
    } catch (error) {
      emit(ProfileFailure(errMessage: error.toString()));
    }
  }

  Future<void> updatedUserData(UserProfileEntity profileEntity) async {
    try {
      emit(ProfileUpdateLoading());
      final updatedProfile =
          await _profileRepository.updateProfileData(profileEntity);

      userProfileData = updatedProfile;

      emit(ProfileUpdateSuccess(updatedProfile));
    } catch (error) {
      emit(ProfileUpdateFailure(errMessage: error.toString()));
    }
  }

  Future<Uint8List?> selectedImageProfile() async {
    final image = await _pickerImageService?.pickImage(ImageSource.gallery);
    if (image != null) {
      profileImage = image;
      emit(ProfileImageUpdated(image: image));
      return image;
    }
    return null;
  }

  Future<void> followUser(String currentUserId, String targetUserId) async {
    try {
      await _profileRepository.followUser(currentUserId, targetUserId);
      userProfileData = userProfileData!.copyWith(
        followers: List<String>.from(userProfileData!.followers)
          ..add(currentUserId),
      );
      emit(ProfileFollowUpdated(
          isFollowed: true, followersCount: userProfileData!.followers.length));
    } catch (error) {
      emit(ProfileFailure(errMessage: error.toString()));
    }
  }

  Future<void> unFollowUser(String currentUserId, String targetUserId) async {
    try {
      await _profileRepository.unFollowUser(currentUserId, targetUserId);
      userProfileData = userProfileData!.copyWith(
        followers: List<String>.from(userProfileData!.followers)
          ..remove(currentUserId),
      );
      emit(ProfileFollowUpdated(
          isFollowed: false,
          followersCount: userProfileData!.followers.length));
    } catch (error) {
      emit(ProfileFailure(errMessage: error.toString()));
    }
  }

  static const String _tag = "profile_instance";

  static ProfileCubit getInstance(String userId) {
    final isRegistered =
        profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (!isRegistered) {
      profileDI.registerSingleton<ProfileCubit>(
        ProfileCubit(profileDI(), userId),
        instanceName: _tag,
      );
    }
    return profileDI.get<ProfileCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegistered =
        profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (isRegistered) {
      final cubit = profileDI<ProfileCubit>(instanceName: _tag);
      await cubit.close();
      profileDI.unregister<ProfileCubit>(instanceName: _tag);
    }
  }
}
