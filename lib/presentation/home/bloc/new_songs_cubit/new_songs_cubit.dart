import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/song/get_new_songs_usecase.dart';
import 'package:music_app/service_locator.dart';

part 'new_songs_state.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsInitial());
  Future<void> getNewSongs() async {
    emit(NewSongsLoading());
    var response = await serviceLocator<GetNewSongsUsecase>().call();
    response.fold(
      (errorMessage) {
        emit(NewSongsFailure(errorMessage: errorMessage));
      },
      (songs) {
        emit(NewSongsLoaded(songs: songs));
      },
    );
  }
}
