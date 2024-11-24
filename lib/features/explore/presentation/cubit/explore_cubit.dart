import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/explore/data/explore_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._exploreRepository) : super(ExploreInitial());

  final ExploreRepository _exploreRepository;

  Future<void> searchUsers(String username) async {
    //TOdO delete this after you display method
    if (username.isEmpty) {
      emit(ExploreInitial());
      return;
    }
    emit(SearchUserLoading());
    try {
      final users = await _exploreRepository.searchUsers(username);
      emit(SearchUserSuccess(users.docs));
    } catch (error) {
      emit(SearchUserFailure(errMessage: error.toString()));
    }
  }
}
