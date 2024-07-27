import 'package:get_it/get_it.dart';
import 'package:music_app/data/data_sources/auth/auth_data_source.dart';
import 'package:music_app/data/data_sources/song/song_data_source.dart';
import 'package:music_app/data/repository/auth/auth_repository_impl.dart';
import 'package:music_app/data/repository/song/song_repository_impl.dart';
import 'package:music_app/domain/repository/auth/auth_repository.dart';
import 'package:music_app/domain/repository/song/song_repository.dart';
import 'package:music_app/domain/usecases/auth/get_user_usecase.dart';
import 'package:music_app/domain/usecases/auth/sign_in_usecase.dart';
import 'package:music_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:music_app/domain/usecases/song/add_or_remove_favorite_usecase.dart';
import 'package:music_app/domain/usecases/song/get_new_songs_usecase.dart';
import 'package:music_app/domain/usecases/song/get_playlist_usecase.dart';
import 'package:music_app/domain/usecases/song/get_user_favorite_songs_usecase.dart';
import 'package:music_app/domain/usecases/song/is_favorite_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  // data sources
  serviceLocator.registerSingleton<AuthDataSource>(
    AuthDataSourceImpl(),
  );
  serviceLocator.registerSingleton<SongDataSource>(
    SongDataSourceImpl(),
  );
  // repositories
  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );
  serviceLocator.registerSingleton<SongRepository>(
    SongRepositoryImpl(),
  );
  // usecases
  serviceLocator.registerSingleton<SignUpUsecase>(
    SignUpUsecase(),
  );
  serviceLocator.registerSingleton<SignInUsecase>(
    SignInUsecase(),
  );
  serviceLocator.registerSingleton<GetUserUsecase>(
    GetUserUsecase(),
  );
  serviceLocator.registerSingleton<GetNewSongsUsecase>(
    GetNewSongsUsecase(),
  );
  serviceLocator.registerSingleton<GetPlaylistUsecase>(
    GetPlaylistUsecase(),
  );
  serviceLocator.registerSingleton<AddOrRemoveFavoriteUsecase>(
    AddOrRemoveFavoriteUsecase(),
  );
  serviceLocator.registerSingleton<IsFavoriteUsecase>(
    IsFavoriteUsecase(),
  );
  serviceLocator.registerSingleton<GetUserFavoriteSongsUsecase>(
    GetUserFavoriteSongsUsecase(),
  );
}
