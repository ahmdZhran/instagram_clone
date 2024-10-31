part of 'add_post_cubit.dart';

sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class MediaLoading extends AddPostState {}

final class MediaLoaded extends AddPostState {
  final List<MediaModel> medias;
  final List<AssetPathEntity> albums;
  final AssetPathEntity currentAlbum;

  MediaLoaded(
      {required this.albums, required this.currentAlbum, required this.medias});
}

class MediaError extends AddPostState {
  final String error;

  MediaError({required this.error});
}
