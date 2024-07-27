import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/configs/theme/app_theme.dart';
import 'package:music_app/presentation/choose_mode/bloc/cubit/theme_cubit.dart';
import 'package:music_app/presentation/home/bloc/new_songs_cubit/new_songs_cubit.dart';
import 'package:music_app/presentation/home/bloc/playlist_cubit/playlist_cubit.dart';
import 'package:music_app/presentation/profile/bloc/favorite_songs_cubit/favorite_songs_cubit.dart';
import 'package:music_app/presentation/profile/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:music_app/presentation/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:music_app/presentation/splash/pages/splash_page.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(create: (context) => NewSongsCubit()),
        BlocProvider(create: (context) => PlaylistCubit()),
        BlocProvider(create: (context) => SongPlayerCubit()),
        BlocProvider(create: (context) => ProfileInfoCubit()),
        BlocProvider(create: (context) => FavoriteSongsCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
