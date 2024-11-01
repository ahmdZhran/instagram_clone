import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/add_media/data/models/media_model.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../../core/services/media_services.dart';
part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit({required this.mediaService}) : super(AddPostInitial());
  final MediaService mediaService;

  Future<void> loadAlbums() async {
    emit(MediaLoading());
    try {
      final albums = await mediaService.fetchAlbums();
      if (albums.isNotEmpty) {
        final currentAlbums = albums.first;
        final medias =
            await mediaService.fetchMedias(album: currentAlbums, page: 0);
        emit(
          MediaLoaded(
              currentAlbum: currentAlbums, medias: medias, albums: albums),
        );
      } else {
        emit(MediaError(error: "We can't find albums"));
      }
    } catch (error) {
      emit(MediaError(error: "Something went wrong during get albums"));
    }
  }

  Future<void> loadMoreMediasInAlbum(AssetPathEntity album, int page) async {
    if (state is MediaLoaded) {
      final currentState = state as MediaLoaded;

      try {
        final newMedias =
            await mediaService.fetchMedias(album: album, page: page);
        emit(MediaLoaded(
          albums: currentState.albums,
          medias: List.from(currentState.medias)..addAll(newMedias),
          currentAlbum: currentState.currentAlbum,
        ));
      } catch (e) {
        emit(MediaError(error: "Something went wrong"));
      }
    }
  }

  Future<void> changeAlbum(AssetPathEntity album) async {
    emit(MediaLoading());
    try {
      final medias = await mediaService.fetchMedias(album: album, page: 0);
      final currentState = state as MediaLoaded;

      emit(
        MediaLoaded(
          albums: currentState.albums,
          currentAlbum: album,
          medias: medias,
        ),
      );
    } catch (e) {
      emit(MediaError(error: "something went wrong"));
    }
  }
}
