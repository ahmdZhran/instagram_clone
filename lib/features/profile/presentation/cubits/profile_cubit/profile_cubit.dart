import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/helper/image_service.dart';
import '../../../data/models/user_post_model.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../../profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial()) {
    _pickerImageService = ImagePickerService();
  }

  final ProfileRepository _profileRepository;
  ImagePickerService? _pickerImageService;
  UserProfileEntity? userProfileData;
  List<UserPostModel>? posts;
  int? postsCount;
  Uint8List? profileImage;

  Future<void> getUserData({required String userId}) async {
    
    try {
      emit(ProfileLoading());
      final userData = await _profileRepository.getProfileData(userId);
      userProfileData = userData;
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

      emit(ProfileUpdateSuccess());
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

  Future<void> getUserPosts(String userId) async {
    try {
      emit(UserPostsLoading());
      final posts = await _profileRepository.getUserPosts(userId);
      postsCount = posts.length;
      emit(UserPostsSuccess(posts: posts));
    } catch (error) {
      emit(UserPostsFailure(errMessage: error.toString()));
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
      final cubit = profileDI<ProfileCubit>(instanceName: _tag);
      await cubit.close();
      profileDI.unregister<ProfileCubit>(instanceName: _tag);
    }
  }
}
