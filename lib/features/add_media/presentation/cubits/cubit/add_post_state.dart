part of 'add_post_cubit.dart';

sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AlbumsLoaded extends AddPostState {
  final List<AssetPathEntity> albums;
  final AssetPathEntity currentAlbums;

  AlbumsLoaded(this.albums, this.currentAlbums);
}

final class MediaLoaded extends AddPostState {
  final List<MediaModel> medias;

  MediaLoaded(this.medias);
}
