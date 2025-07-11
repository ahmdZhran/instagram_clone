part of 'reel_cubit.dart';

sealed class ReelState {}

final class ReelInitial extends ReelState {}

final class ReelLoading extends ReelState {}

final class ReelSuccess extends ReelState {
  final List<ReelModel> reels;
  ReelSuccess(this.reels);
}

final class ReelFailure extends ReelState {
  final String errorMessage;
  ReelFailure({required this.errorMessage});
}
