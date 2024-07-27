part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {
  final bool isFavorite;
  FavoriteInitial({
    required this.isFavorite,
  });
}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteUpdated extends FavoriteState {
  final bool isFavorite;
  FavoriteUpdated({
    required this.isFavorite,
  });
}

final class FavoriteFailure extends FavoriteState {
  final String errorMessage;
  FavoriteFailure({
    required this.errorMessage,
  });
}
