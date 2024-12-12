import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/home_Repository.dart';
import '../../../home_di.dart';
import '../../../../posts/domain/entities/post_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitial());

  final HomeRepository _homeRepository;
  void fetchPosts() {
    emit(HomePostsLoading());
    _homeRepository.fetchAllPosts().then((stream) {
      stream.listen((posts) {
        emit(HomePostsSuccess(posts));
      }, onError: (error) {
        emit(HomePostsFailure(errMessage: error.toString()));
      });
    }).catchError((error) {
      emit(HomePostsFailure(errMessage: error.toString()));
    });
  }

  Future<void> toggleLikedPost(String postId, String userId) async {
    final currentState = state as HomePostsSuccess;
    List<PostEntity> updatedPosts =
        _updatedPostLike(currentState, postId, userId);
    emit(HomePostsSuccess(updatedPosts));
    try {
      await _homeRepository.toggleLikedPost(postId, userId);
    } catch (error) {
      emit(HomePostsFailure(errMessage: "Failed to toggle like: $error"));
    }
  }

  List<PostEntity> _updatedPostLike(
      HomePostsSuccess currentState, String postId, String userId) {
    final updatedPosts = currentState.posts!.map((post) {
      if (post.id == postId) {
        final isLiked = post.likes.contains(userId);
        final updatedLikes = isLiked
            ? post.likes.where((id) => id != userId).toList()
            : [...post.likes, userId];

        return post.copyWith(likes: updatedLikes);
      }
      return post;
    }).toList();
    return updatedPosts;
  }


  static const String _tag = "home_instance";
  static HomeCubit getInstance() {
    final isRegister = homeDI.isRegistered<HomeCubit>(instanceName: _tag);
    if (!isRegister) {
      homeDI.registerSingleton<HomeCubit>(
        HomeCubit(homeDI<HomeRepository>()),
        instanceName: _tag,
      );
    }
    return homeDI.get<HomeCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = homeDI.isRegistered<HomeCubit>(instanceName: _tag);
    if (isRegister) {
      final cubit = homeDI<HomeCubit>(instanceName: _tag);
      await cubit.close();
      homeDI.unregister<HomeCubit>(instanceName: _tag);
    }
  }
}
