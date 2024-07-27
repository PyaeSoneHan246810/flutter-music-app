import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/song/get_playlist_usecase.dart';
import 'package:music_app/service_locator.dart';

part 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistInitial());
  Future<void> getPlaylist() async {
    emit(PlaylistLoading());
    var response = await serviceLocator<GetPlaylistUsecase>().call();
    response.fold(
      (errorMessage) {
        emit(PlaylistFailure(errorMessage: errorMessage));
      },
      (songs) {
        emit(PlaylistLoaded(songs: songs));
      },
    );
  }
}
