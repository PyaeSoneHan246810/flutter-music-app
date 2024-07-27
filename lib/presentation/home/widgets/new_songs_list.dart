import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/configs/constants/app_urls.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/home/bloc/new_songs_cubit/new_songs_cubit.dart';
import 'package:music_app/presentation/song_player/pages/song_player_page.dart';

class NewSongsList extends StatefulWidget {
  const NewSongsList({super.key});

  @override
  State<NewSongsList> createState() => _NewSongsListState();
}

class _NewSongsListState extends State<NewSongsList> {
  @override
  void initState() {
    super.initState();
    context.read<NewSongsCubit>().getNewSongs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSongsCubit, NewSongsState>(
      builder: (context, state) {
        if (state is NewSongsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NewSongsLoaded) {
          return _songs(state.songs);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Padding(
          padding: EdgeInsets.only(
            left: (index == 0) ? 20 : 0,
            right: (index == songs.length - 1) ? 20 : 0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SongPlayerPage(
                      songEntity: song,
                    );
                  },
                ),
              );
            },
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "${AppURLs.coverFireStorage}${song.artist} - ${song.title}.jpg?${AppURLs.mediaAlt}"),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          transform: Matrix4.translationValues(
                            10,
                            10,
                            0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(song.artist),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 16,
        );
      },
      itemCount: songs.length,
    );
  }
}
