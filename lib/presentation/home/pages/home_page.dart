import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/common/widgets/appbar/basic_app_bar.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/home/widgets/new_songs_list.dart';
import 'package:music_app/presentation/home/widgets/playlist.dart';
import 'package:music_app/presentation/profile/pages/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: SvgPicture.asset(
          AppVectors.appLogo,
          height: 36,
          fit: BoxFit.cover,
        ),
        hideBackButton: true,
        action: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ProfilePage();
                },
              ),
            );
          },
          icon: const Icon(Icons.person_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            const SizedBox(
              height: 40,
            ),
            _tabs(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 260,
              child: _tabViews(),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Playlist",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text("See more"),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Playlist()
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(
                  AppImages.homeArtist,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      labelColor: Theme.of(context).colorScheme.onSurface,
      dividerColor: Theme.of(context).colorScheme.surface,
      indicatorColor: AppColors.primary,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      tabs: const [
        Text("News"),
        Text("Videos"),
        Text("Artists"),
        Text("Podcasts"),
      ],
    );
  }

  Widget _tabViews() {
    return TabBarView(
      controller: _tabController,
      children: [
        const NewSongsList(),
        Container(),
        Container(),
        Container(),
      ],
    );
  }
}
