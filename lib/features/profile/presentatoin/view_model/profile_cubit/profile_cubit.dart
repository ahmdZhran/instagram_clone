import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/prfile_model.dart';
import 'package:meta/meta.dart';
import 'user_repositry.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepository) : super(ProfileInfoInitial());
  final UserRepositry userRepository;
  void getUserProfile() async {
    try {
      emit(ProfileInfoLoading());
      final userProfile = await userRepository.getUserDetails();
      emit(ProfileInfoSuccess(userProfile: userProfile));
    } catch (e) {
      emit(ProfileInfoFailer(errMessage: e.toString()));
    }
  }

  void uploadProfileImage(String imagePath) async {
    try {
      emit(UserImageSelectedLoading());
      await userRepository.uploadProfileImage(imagePath);
      emit(UserImageSelectedSuccess());
    } catch (e) {
      emit(UserImageSelectedFailure(errMessage: e.toString()));
    }
  }
}
