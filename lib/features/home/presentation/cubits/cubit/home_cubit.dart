import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/domain/repositories/home_Repository.dart';

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
}
