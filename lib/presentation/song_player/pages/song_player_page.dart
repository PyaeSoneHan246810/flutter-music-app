import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/widgets/appbar/basic_app_bar.dart';
import 'package:music_app/common/widgets/buttons/favorite_icon_button.dart';
import 'package:music_app/core/configs/constants/app_urls.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/song_player/bloc/cubit/song_player_cubit.dart';

class SongPlayerPage extends StatefulWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    super.key,
    required this.songEntity,
  });

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  @override
  void initState() {
    super.initState();
    context.read<SongPlayerCubit>().loadSong(
        "${AppURLs.songFireStorage}${widget.songEntity.artist} - ${widget.songEntity.title}.mp3?${AppURLs.mediaAlt}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: const Text(
          "Now Playing",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          children: [
            _songCover(context, widget.songEntity),
            const SizedBox(
              height: 12,
            ),
            _songDetails(context, widget.songEntity),
            const SizedBox(
              height: 12,
            ),
            _songPlayer(),
          ],
        ),
      ),
    );
  }

  Widget _songCover(
    BuildContext context,
    SongEntity song,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              "${AppURLs.coverFireStorage}${song.artist} - ${song.title}.jpg?${AppURLs.mediaAlt}"),
        ),
      ),
    );
  }

  Widget _songDetails(BuildContext context, SongEntity song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  song.artist,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
        FavoriteIconButton(
          song: song,
        )
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                min: 0.0,
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
                inactiveColor: Theme.of(context).colorScheme.outline,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                  ),
                ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }
}
