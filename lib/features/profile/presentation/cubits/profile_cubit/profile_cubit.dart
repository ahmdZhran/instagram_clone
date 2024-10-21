import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/data/repositories/profile_repository.dart';
import 'package:instagram_clone/features/profile/domain/entities/user_profile_entity.dart';

import '../../../profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  final ProfileRepository _profileRepository;
  UserProfileEntity? _cachedUserProfile;

  Future<void> getUserData(String userId) async {
    if (_cachedUserProfile != null) {
      emit(ProfileSuccess(_cachedUserProfile!));

      return;
    }
    try {
      emit(ProfileLoading());
      final userData = await _profileRepository.getProfileData(userId);
      _cachedUserProfile = userData;
      emit(ProfileSuccess(userData));
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
      final cubit = profileDI<ProfileCubit>(instanceName: _tag);
      await cubit.close();
      profileDI.unregister<ProfileCubit>(instanceName: _tag);
    }
  }
}
