// MODEL & DTO


import 'package:my_app/model/song.dart';

class SongDto {
  static Song fromJson(String id, Map<String, dynamic> json) {
    return Song(
      id: id,
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      album: json['album'] ?? '',
    );
  }

  static Map<String, dynamic> toJson(Song song) {
    return {'title': song.title, 'artis': song.artist, 'album': song.album};
  }
}
