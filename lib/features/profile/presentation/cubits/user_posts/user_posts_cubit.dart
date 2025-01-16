import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_post_model.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../profile_di.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit(this._profileRepository) : super(UserPostsInitial());

  final ProfileRepository _profileRepository;
  List<UserPostModel>? postsList;
  int? postsCount;
  Future<void> getUserPosts(String userId) async {
    try {
      emit(UserPostsLoading());
      final posts = await _profileRepository.getUserPosts(userId);
      postsList = posts;
      postsCount = posts.length;
      emit(UserPostsSuccess());
    } catch (error) {
      emit(UserPostsFailure(errMessage: error.toString()));
    }
  }

  static const String _tag = "user_posts_cubit";

  static UserPostsCubit getInstance() {
    final isRegistered =
        profileDI.isRegistered<UserPostsCubit>(instanceName: _tag);
    if (!isRegistered) {
      profileDI.registerSingleton<UserPostsCubit>(
        UserPostsCubit(profileDI()),
        instanceName: _tag,
      );
    }
    return profileDI.get<UserPostsCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegistered =
        profileDI.isRegistered<UserPostsCubit>(instanceName: _tag);
    if (isRegistered) {
      profileDI<UserPostsCubit>(instanceName: _tag);
      // await cubit.close();
      profileDI.unregister<UserPostsCubit>(instanceName: _tag);
    }
  }
}
