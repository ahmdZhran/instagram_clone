import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';
import 'package:instagram_clone/features/reels/data/repositories/reels_repository.dart';

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

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
