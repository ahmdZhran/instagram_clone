import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/domain/repositories/home_Repository.dart';

import '../../../domain/entities/comment_entity/comment_entity.dart';
import '../../../home_di.dart';
import '../home_cubit/home_cubit.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this._homeRepository) : super(CommentInitial());

  final HomeRepository _homeRepository;
  
  Future<void> addComment(String postId, CommentEntity comment) async {
    emit(AddCommentLoading());
    try {
      await _homeRepository.addComment(postId, comment);
      emit(AddCommentSuccess());
    } catch (error) {
      emit(AddCommentFailure(errMessage: error.toString()));
    }
  }



  static const String _tag = "home_instance";
  static CommentCubit getInstance() {
    final isRegister = homeDI.isRegistered<CommentCubit>(instanceName: _tag);
    if (!isRegister) {
      homeDI.registerSingleton<HomeCubit>(
        HomeCubit(homeDI<HomeRepository>()),
        instanceName: _tag,
      );
    }
    return homeDI.get<CommentCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = homeDI.isRegistered<CommentCubit>(instanceName: _tag);
    if (isRegister) {
      final cubit = homeDI<CommentCubit>(instanceName: _tag);
      await cubit.close();
      homeDI.unregister<CommentCubit>(instanceName: _tag);
    }
  }
}
