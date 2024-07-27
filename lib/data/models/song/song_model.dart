import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/domain/entities/song/song.dart';

class SongModel {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  bool isFavorite;
  String songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'isFavorite': isFavorite,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      title: map['title'] as String,
      artist: map['artist'] as String,
      duration: map['duration'] as num,
      releaseDate: map['releaseDate'] as Timestamp,
      isFavorite: false,
      songId: "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title,
      artist: artist,
      duration: duration,
      releaseDate: releaseDate,
      isFavorite: isFavorite,
      songId: songId,
    );
  }
}
