import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/data/repositories/profile_repository.dart';
import 'package:instagram_clone/features/profile/domain/entities/user_profile_entity.dart';

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
}
