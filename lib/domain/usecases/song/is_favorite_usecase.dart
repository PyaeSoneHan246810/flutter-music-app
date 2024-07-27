import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/domain/repository/song/song_repository.dart';
import 'package:music_app/service_locator.dart';

class IsFavoriteUsecase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await serviceLocator<SongRepository>().isFavoriteSong(params!);
  }
}
