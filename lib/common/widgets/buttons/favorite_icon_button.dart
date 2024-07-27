import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:music_app/domain/entities/song/song.dart';

class FavoriteIconButton extends StatelessWidget {
  final SongEntity song;
  final Function? function;
  const FavoriteIconButton({
    super.key,
    required this.song,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..initialize(song.songId),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteCubit>().updateFavorite(song.songId);
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: Theme.of(context).colorScheme.outline,
              ),
            );
          }
          if (state is FavoriteUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteCubit>().updateFavorite(song.songId);
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: Theme.of(context).colorScheme.outline,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
