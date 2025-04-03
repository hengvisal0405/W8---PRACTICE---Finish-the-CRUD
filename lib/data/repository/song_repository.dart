
import 'package:my_app/model/song.dart';

abstract class SongRepository {
  Future<Song> addSong(
      {required String title, required String artist, required String album});
  Future<List<Song>> getSongs();
  Future<void> deleteSong(String id);
  Future<void> updateSong(Song song);
}
