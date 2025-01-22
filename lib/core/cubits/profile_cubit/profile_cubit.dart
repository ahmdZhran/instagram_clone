import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/profile/data/models/user_model.dart';
import '../../helper/image_service.dart';
import '../../models/user_profile_manager.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import '../../../features/profile/profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial()) {
    _pickerImageService = ImagePickerService();
  }

  final ProfileRepository _profileRepository;
  ImagePickerService? _pickerImageService;
  UserProfileDataModel? userProfileData;
  Uint8List? profileImage;

  UserProfileDataModel get getUserProfileData => userProfileData!;
  Uint8List get getProfileImage => profileImage!;

  Future<void> getUserData({required String userId}) async {
    try {
      emit(ProfileLoading());
      final userData = await _profileRepository.getProfileData(userId);
      userProfileData = userData;
      UserProfileManager().updateUserProfileIfCurrentUser(userData, userId);
      emit(ProfileSuccess());
    } catch (error) {
      emit(ProfileFailure(errMessage: error.toString()));
    }
  }

  Future<void> updatedUserData(UserProfileDataModel profileEntity) async {
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

  static ProfileCubit getInstance() {
    final isRegistered =
        profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (!isRegistered) {
      profileDI.registerSingleton<ProfileCubit>(
        ProfileCubit(profileDI()),
        instanceName: _tag,
      );
    }
    return profileDI.get<ProfileCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegistered =
        profileDI.isRegistered<ProfileCubit>(instanceName: _tag);
    if (isRegistered) {
      profileDI<ProfileCubit>(instanceName: _tag);
      profileDI.unregister<ProfileCubit>(instanceName: _tag);
    }
  }
}
