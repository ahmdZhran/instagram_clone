part of 'explore_cubit.dart';

sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class SearchUserLoading extends ExploreState {}

final class SearchUserSuccess extends ExploreState {
  
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> users;

  SearchUserSuccess(this.users);
}

final class SearchUserFailure extends ExploreState {
  final String errMessage;

  SearchUserFailure({required this.errMessage});
}
