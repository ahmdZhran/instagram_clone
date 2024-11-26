import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/explore/data/explore_repository.dart';
import 'package:instagram_clone/features/explore/domain/entities/search_user_entity.dart';
import 'package:instagram_clone/features/explore/explore_di.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._exploreRepository) : super(ExploreInitial());

  final ExploreRepository _exploreRepository;

  Future<void> searchUsers(String username) async {
  
    emit(SearchUserLoading());
    try {
      final users = await _exploreRepository.searchUsers(username);
      emit(SearchUserSuccess(users));
    } catch (error) {
      emit(SearchUserFailure(errMessage: error.toString()));
    }
  }


static const String _tag = "explore_instance";

  static ExploreCubit getInstance() {
    final isRegistered =
        exploreDI.isRegistered<ExploreCubit>(instanceName: _tag);
    if (!isRegistered) {
      exploreDI.registerSingleton<ExploreCubit>(
        ExploreCubit(exploreDI()),
        instanceName: _tag,
      );
    }
    return exploreDI.get<ExploreCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegistered =
        exploreDI.isRegistered<ExploreCubit>(instanceName: _tag);
    if (isRegistered) {
      final cubit = exploreDI<ExploreCubit>(instanceName: _tag);
      await cubit.close();
      exploreDI.unregister<ExploreCubit>(instanceName: _tag);
    }
  }

}
