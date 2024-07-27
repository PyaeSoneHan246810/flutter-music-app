import 'package:dartz/dartz.dart';
import 'package:music_app/data/data_sources/song/song_data_source.dart';
import 'package:music_app/domain/repository/song/song_repository.dart';
import 'package:music_app/service_locator.dart';

class SongRepositoryImpl implements SongRepository {
  @override
  Future<Either> getNewSongs() async {
    return await serviceLocator<SongDataSource>().getNewSongs();
  }

  @override
  Future<Either> getPlaylist() async {
    return await serviceLocator<SongDataSource>().getPlaylist();
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    return await serviceLocator<SongDataSource>().addOrRemoveSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await serviceLocator<SongDataSource>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await serviceLocator<SongDataSource>().getUserFavoriteSongs();
  }
}
