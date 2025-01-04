import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/comment_entity/comment_entity.dart';
import '../../../domain/repositories/home_Repository.dart';
import '../../../home_di.dart';
import '../../../../posts/domain/entities/post_entity.dart';
import '../comment_cubit/comment_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitial());

  final HomeRepository _homeRepository;
  StreamSubscription? _streamSubscription;
  StreamSubscription? _commentsSubscription;
  Future<void> fetchPosts() async {
    emit(HomePostsLoading());
    try {
      final postsStream = await _homeRepository.fetchAllPosts();
      _streamSubscription = postsStream.listen((posts) {
        emit(HomePostsSuccess(posts));
      }, onError: (error) {
        emit(HomePostsFailure(errMessage: error));
      });
    } catch (error) {
      emit(HomePostsFailure(errMessage: error.toString()));
    }
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

  Future<void> addComment(String postId, CommentEntity comment) async {
    emit(AddCommentLoading());
    try {
      await _homeRepository.addComment(postId, comment);
      emit(AddCommentSuccess(comment: comment));
    } catch (error) {
      emit(AddCommentFailure(errMessage: error.toString()));
    }
  }

  Future<void> fetchComments(String postId) async {
    emit(FetchCommentLoading());
    try {
      final commentsStream = await _homeRepository.fetchComments(postId);
      _commentsSubscription = commentsStream.listen((comments) {
        emit(FetchCommentSuccess(comments: comments));
      }, onError: (error) {
        emit(FetchCommentFailure(errMessage: error.toString()));
      });
    } catch (error) {
      emit(FetchCommentFailure(errMessage: error.toString()));
    }
  }

  Future<void> deleteComment(String postId, String commentId) async {
    emit(DeleteCommentLoading());
    try {
      await _homeRepository.deleteComment(postId, commentId);
      emit(DeleteCommentSuccess(commentId: commentId));
    } catch (error) {
      emit(DeleteCommentFailure(errMessage: error.toString()));
    }
  }

  Future<void> editComment(
      String postId, String commentId, String updatedComment) async {
    try {
      await _homeRepository.editComment(postId, commentId, updatedComment);
      emit(EditCommentSuccess(
          commentId: commentId, updatedComment: updatedComment));
    } catch (error) {
      emit(EditCommentFailure(errMessage: error.toString()));
    }
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

  @override
  Future<void> close() {
    _commentsSubscription!.cancel();
    _streamSubscription!.cancel();
    return super.close();
  }
}
