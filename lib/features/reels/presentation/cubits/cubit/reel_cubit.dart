import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';
import 'package:instagram_clone/features/reels/data/repositories/reels_repository.dart';
import 'package:instagram_clone/features/reels/reel_di.dart';

part 'reel_state.dart';

class ReelCubit extends Cubit<ReelState> {
  ReelCubit(this._reelsRepository) : super(ReelInitial());
  final ReelsRepository _reelsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> fetchReels() async {
    try {
      final postsStream = await _reelsRepository.getAllReels();
      _streamSubscription = postsStream.listen((reels) {
        emit(ReelSuccess(reels));
      }, onError: (error) {
        emit(ReelFailure(errorMessage: error.toString()));
      });
    } catch (error) {
      emit(ReelFailure(errorMessage: error.toString()));
    }
  }

  static const String _tag = "home_instance";
  static ReelCubit getInstance() {
    final isRegister = reelDI.isRegistered<ReelCubit>(instanceName: _tag);
    if (!isRegister) {
      reelDI.registerSingleton<ReelCubit>(
        ReelCubit(reelDI<ReelsRepository>()),
        instanceName: _tag,
      );
    }
    return reelDI.get<ReelCubit>(instanceName: _tag);
  }

  static Future<void> deleteInstance() async {
    final isRegister = reelDI.isRegistered<ReelCubit>(instanceName: _tag);
    if (isRegister) {
      reelDI<ReelCubit>(instanceName: _tag);
      reelDI.unregister<ReelCubit>(instanceName: _tag);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
