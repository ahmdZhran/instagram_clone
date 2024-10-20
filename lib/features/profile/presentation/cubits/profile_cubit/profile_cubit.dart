import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/data/repositories/profile_repository.dart';
import 'package:instagram_clone/features/profile/domain/entities/user_profile_entity.dart';

import '../../../profile_di.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  final ProfileRepository _profileRepository;

  Future<void> getUserData(String userId) async {
    try {
      emit(ProfileLoading());
      final user = await _profileRepository.getProfileData(userId);
      emit(ProfileSuccess(userData: user));
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
