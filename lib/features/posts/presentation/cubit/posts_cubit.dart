import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/services/firebase_storage_service.dart';
import 'package:instagram_clone/features/posts/post_di.dart';
import 'package:instagram_clone/features/posts/domain/repositories/post_repository.dart';

import '../../domain/entities/post_entity.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._addPostRepository) : super(PostsInitial());
  final PostRepository _addPostRepository;
  Future<void> createPost({
    required Uint8List image,
    required PostEntity post,
    required String folderName,
  }) async {
    emit(PostsLoading());
    try {
      final imageUrl = await FirebaseStorageService.uploadImagesToFireStorage(
        image,
        post.id,
        folderName,
      );

      final postWithImage = post.copyWith(imageUrl: imageUrl);

      await _addPostRepository.createPost(postWithImage);

      emit(PostsSuccess());
    } catch (error) {
      emit(PostsFailure(errMessage: error.toString()));
    }
  }

  void fetchPosts() {
    emit(PostsLoading());
    _addPostRepository.fetchAllPosts().then((stream) {
      stream.listen((posts) {
        emit(PostsSuccess(posts));
      }, onError: (error) {
        emit(PostsFailure(errMessage: error.toString()));
      });
    }).catchError((error) {
      emit(PostsFailure(errMessage: error.toString()));
    });
  }

  Future<void> deletePost(String postId) async {
    try {
      emit(PostsLoading());
      await _addPostRepository.deletePost(postId);
      emit(PostsSuccess());
    } catch (error) {
      emit(PostsFailure(errMessage: error.toString()));
    }
  }

  static const String _tag = "posts";
  static PostsCubit getInstance() {
    final isRegister = addPostDi.isRegistered<PostsCubit>(instanceName: _tag);
    if (!isRegister) {
      addPostDi.registerSingleton<PostsCubit>(
        PostsCubit(addPostDi<PostRepository>()),
        instanceName: _tag,
      );
    }
    return addPostDi.get<PostsCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = addPostDi.isRegistered<PostsCubit>(instanceName: _tag);
    if (isRegister) {
      final cubit = addPostDi<PostsCubit>(instanceName: _tag);
      await cubit.close();
      addPostDi.unregister<PostsCubit>(instanceName: _tag);
    }
  }
}
