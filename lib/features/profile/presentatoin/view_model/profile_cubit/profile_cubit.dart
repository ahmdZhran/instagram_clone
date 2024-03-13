import 'package:flutter_bloc/flutter_bloc.dart';
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
}
