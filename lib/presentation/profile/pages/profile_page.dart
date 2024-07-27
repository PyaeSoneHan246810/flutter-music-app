import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/widgets/appbar/basic_app_bar.dart';
import 'package:music_app/common/widgets/buttons/favorite_icon_button.dart';
import 'package:music_app/core/configs/constants/app_urls.dart';
import 'package:music_app/presentation/profile/bloc/favorite_songs_cubit/favorite_songs_cubit.dart';
import 'package:music_app/presentation/profile/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:music_app/presentation/song_player/pages/song_player_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileInfoCubit>().getUser();
    context.read<FavoriteSongsCubit>().getFavoriteSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: const Text("Pofile"),
        backgroundColor: context.isDarkMode
            ? const Color(0xff2c2828)
            : const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileInfo(),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Favorite Songs",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _favoriteSongs()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileInfo() {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        if (state is ProfileInfoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileInfoLoaded) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? const Color(0xff2c2828)
                  : const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        state.userEntity.imageUrl,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(state.userEntity.email),
                Text(
                  state.userEntity.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _favoriteSongs() {
    return BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
      builder: (context, state) {
        if (state is FavoriteSongsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FavoriteSongsLoaded) {
          return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var song = state.favoriteSongs[index];
              return GestureDetector(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${AppURLs.coverFireStorage}${song.artist} - ${song.title}.jpg?${AppURLs.mediaAlt}"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              song.artist,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          song.duration.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        FavoriteIconButton(
                          key: UniqueKey(),
                          song: song,
                          function: () {
                            context
                                .read<FavoriteSongsCubit>()
                                .removeSong(index);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: state.favoriteSongs.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
