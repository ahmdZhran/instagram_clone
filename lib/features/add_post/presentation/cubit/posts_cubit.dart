import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/add_post/domain/repositories/add_post_repository.dart';

import '../../domain/entities/post_entity.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._addPostRepository, this._storage) : super(PostsInitial());
  final AddPostRepository _addPostRepository;
  final FirebaseStorage _storage;
  
}
