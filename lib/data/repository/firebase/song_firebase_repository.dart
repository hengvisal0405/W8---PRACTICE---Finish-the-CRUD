import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_app/data/dto/song_dto.dart';
import 'package:my_app/data/repository/song_repository.dart';
import 'package:my_app/model/song.dart';

class FirebaseSongRepository extends SongRepository {
  static const String baseUrl =
      'https://week8-crud-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String songCollection = "songs";
  static const String allSongUrl = '$baseUrl/$songCollection.json';
  @override
  Future<Song> addSong({
    required String title,
    required String artist,
    required String album,
  }) async {
    Uri uri = Uri.parse(allSongUrl);
    // Create a new data
    final newSongData = {'title': title, 'artist': artist, 'album': album};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newSongData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }
    // Firebase returns the new ID in 'name'
    final newId = json.decode(response.body)['name'];

    // Return created user
    return Song(id: newId, title: title, artist: artist, album: album);
  }

  @override
  Future<List<Song>> getSongs() async {
    Uri uri = Uri.parse(allSongUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => SongDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<void> deleteSong(String id) {
    Uri uri = Uri.parse('$baseUrl/$songCollection/$id.json');
    return http.delete(uri).then((response) {
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to delete user');
      }
    });
  }

  @override
  Future<void> updateSong(Song song) {
    Uri uri = Uri.parse('$baseUrl/$songCollection/${song.id}.json');
    final songData = {
      'title': song.title,
      'artist': song.artist,
      'album': song.album,
    };
    return http.put(uri, body: json.encode(songData)).then((response) {
      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to update user');
      }
    });
  }
}
