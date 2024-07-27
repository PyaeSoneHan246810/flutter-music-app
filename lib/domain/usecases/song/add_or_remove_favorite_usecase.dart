import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/domain/repository/song/song_repository.dart';
import 'package:music_app/service_locator.dart';

class AddOrRemoveFavoriteUsecase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await serviceLocator<SongRepository>()
        .addOrRemoveFavoriteSong(params!);
  }
}
