import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/domain/repositories/home_Repository.dart';
import 'package:instagram_clone/features/home/home_di.dart';

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

  static const String _tag = "posts";
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
}
