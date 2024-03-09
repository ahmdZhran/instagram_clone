// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/models/user_model.dart';
import 'package:meta/meta.dart';

import 'package:instagram_clone/core/models/user_repositry.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepositry) : super(ProfileInitial());
  final UserRepositry userRepositry;
  Future<void> fetchUserProfile(String documentId) async {
    try {
      emit(ProfileLoading());

      final profile = await userRepositry.getUser(documentId);
      emit(ProfileSuccess(userModel: profile));
    } catch (e) {
      emit(ProfileFailer(errMessage: e.toString()));
    }
  }
}
