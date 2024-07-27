import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/song/get_user_favorite_songs_usecase.dart';
import 'package:music_app/service_locator.dart';

part 'favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsInitial());
  List<SongEntity> favoriteSongs = [];
  Future<void> getFavoriteSongs() async {
    emit(FavoriteSongsLoading());
    var response = await serviceLocator<GetUserFavoriteSongsUsecase>().call();
    response.fold(
      (errorMessage) {
        emit(FavoriteSongsFailure(errorMessage: errorMessage));
      },
      (songs) {
        favoriteSongs = songs;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      },
    );
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
