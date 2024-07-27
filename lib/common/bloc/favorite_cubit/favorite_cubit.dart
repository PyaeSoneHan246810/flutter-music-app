import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/usecases/song/add_or_remove_favorite_usecase.dart';
import 'package:music_app/domain/usecases/song/is_favorite_usecase.dart';
import 'package:music_app/service_locator.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteLoading());

  Future<void> initialize(String songId) async {
    bool isFavorite =
        await serviceLocator<IsFavoriteUsecase>().call(params: songId);
    emit(FavoriteInitial(isFavorite: isFavorite));
  }

  Future<void> updateFavorite(String songId) async {
    var response =
        await serviceLocator<AddOrRemoveFavoriteUsecase>().call(params: songId);
    response.fold(
      (errorMessage) {
        emit(FavoriteFailure(errorMessage: errorMessage));
      },
      (isAdded) {
        emit(FavoriteUpdated(isFavorite: isAdded));
      },
    );
  }
}
