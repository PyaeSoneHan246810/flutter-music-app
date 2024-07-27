part of 'new_songs_cubit.dart';

@immutable
sealed class NewSongsState {}

final class NewSongsInitial extends NewSongsState {}

final class NewSongsLoading extends NewSongsState {}

final class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;

  NewSongsLoaded({
    required this.songs,
  });
}

final class NewSongsFailure extends NewSongsState {
  final String errorMessage;
  NewSongsFailure({
    required this.errorMessage,
  });
}
