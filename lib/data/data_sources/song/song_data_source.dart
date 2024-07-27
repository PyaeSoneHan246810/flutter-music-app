import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/data/models/song/song_model.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/song/is_favorite_usecase.dart';
import 'package:music_app/service_locator.dart';

abstract class SongDataSource {
  Future<Either> getNewSongs();
  Future<Either> getPlaylist();
  Future<Either> addOrRemoveSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongDataSourceImpl implements SongDataSource {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy(
            "releaseDate",
            descending: true,
          )
          .limit(3)
          .get();
      for (var doc in data.docs) {
        var songModel = SongModel.fromMap(doc.data());
        bool isFavorite = await serviceLocator<IsFavoriteUsecase>().call(
          params: doc.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = doc.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error has occurred, Please try again!");
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy(
            "releaseDate",
            descending: true,
          )
          .get();
      for (var doc in data.docs) {
        var songModel = SongModel.fromMap(doc.data());
        bool isFavorite = await serviceLocator<IsFavoriteUsecase>().call(
          params: doc.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = doc.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error has occurred, Please try again!");
    }
  }

  @override
  Future<Either> addOrRemoveSong(String songId) async {
    try {
      late bool isAdded;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      String userId = firebaseAuth.currentUser!.uid;
      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .where("songId", isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isAdded = false;
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(userId)
            .collection("favorites")
            .add(
          {
            "songId": songId,
            "addedDate": Timestamp.now(),
          },
        );
        isAdded = true;
      }
      return Right(isAdded);
    } catch (e) {
      return const Left("An error has occurred, Please try again!");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      String userId = firebaseAuth.currentUser!.uid;
      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .where("songId", isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      List<SongEntity> songs = [];
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      String userId = firebaseAuth.currentUser!.uid;
      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .get();
      for (var doc in favoriteSongs.docs) {
        String songId = doc["songId"];
        var song =
            await firebaseFirestore.collection("songs").doc(songId).get();
        SongModel songModel = SongModel.fromMap(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error has occurred, Please try again!");
    }
  }
}
