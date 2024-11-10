import 'package:bloc/bloc.dart';
import 'package:instagram_clone/features/add_post/domain/entities/post_entity.dart';
import 'package:meta/meta.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
}
