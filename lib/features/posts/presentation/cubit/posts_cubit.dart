import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/posts/data/models/post_model.dart';
import '../../../../core/services/firebase_storage_service.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../post_di.dart';


part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._postRepository) : super(PostsInitial());


  final PostRepositoryImpl _postRepository;

  Future<void> createPost({
    required Uint8List image,
    required PostModel post,
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

      await _postRepository.createPost(postWithImage);

      emit(PostsSuccess());
    } catch (error) {
      emit(PostsFailure(errMessage: error.toString()));
    }
  }


  Future<void> deletePost(String postId) async {
    try {
      emit(PostsLoading());
      await _postRepository.deletePost(postId);
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
        PostsCubit(addPostDi<PostRepositoryImpl>()),
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