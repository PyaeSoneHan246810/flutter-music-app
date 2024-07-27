part of 'playlist_cubit.dart';

@immutable
sealed class PlaylistState {}

final class PlaylistInitial extends PlaylistState {}

final class PlaylistLoading extends PlaylistState {}

final class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;

  PlaylistLoaded({
    required this.songs,
  });
}

final class PlaylistFailure extends PlaylistState {
  final String errorMessage;
  PlaylistFailure({
    required this.errorMessage,
  });
}
