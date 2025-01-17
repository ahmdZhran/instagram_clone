import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/posts/data/models/post_model.dart';
import '../../../domain/repositories/home_Repository.dart';
import '../../../home_di.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitial());

  final HomeRepository _homeRepository;
  StreamSubscription? _streamSubscription;
  List<PostModel>? posts;

  Future<void> fetchPosts() async {
    emit(HomePostsLoading());
    try {
      final postsStream = await _homeRepository.fetchAllPosts();
      _streamSubscription = postsStream.listen((posts) {
        emit(HomePostsSuccess(posts));
      }, onError: (error) {
        emit(HomePostsFailure(errMessage: error.toString()));
      });
    } catch (error) {
      emit(HomePostsFailure(errMessage: error.toString()));
    }
  }

  Future<void> deletePost(String postId) async {
    emit(DeleteUserPostLoading());
    try {
      await _homeRepository.deletePost(postId);
      emit(DeleteUserPostSuccess());
      fetchPosts();
    } catch (error) {
      emit(DeleteUserPostFailure(errMessage: error.toString()));
    }
  }

  Future<void> toggleLikedPost(String postId, String userId) async {
    final currentState = state as HomePostsSuccess;
    List<PostModel> updatedPosts =
        _updatedPostLike(currentState, postId, userId);
    emit(HomePostsSuccess(updatedPosts));
    try {
      await _homeRepository.toggleLikedPost(postId, userId);
    } catch (error) {
      emit(HomePostsFailure(errMessage: "Failed to toggle like: $error"));
    }
  }

  List<PostModel> _updatedPostLike(
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
      homeDI<HomeCubit>(instanceName: _tag);
      homeDI.unregister<HomeCubit>(instanceName: _tag);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
