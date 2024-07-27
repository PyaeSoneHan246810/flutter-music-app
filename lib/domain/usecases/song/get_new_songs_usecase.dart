import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/domain/repository/song/song_repository.dart';
import 'package:music_app/service_locator.dart';

class GetNewSongsUsecase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await serviceLocator<SongRepository>().getNewSongs();
  }
}
