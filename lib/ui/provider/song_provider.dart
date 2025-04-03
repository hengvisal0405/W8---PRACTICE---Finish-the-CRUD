// PROVIDER
import 'package:flutter/material.dart';
import 'package:my_app/data/repository/song_repository.dart';
import 'package:my_app/model/song.dart';
import 'package:my_app/ui/provider/async_value.dart';

class SongProvider extends ChangeNotifier {
  final SongRepository _repository;
  AsyncValue<List<Song>>? songsState;

  SongProvider(this._repository) {
    fetchSong();
  }

  bool get isLoading =>
      songsState != null && songsState!.state == AsyncValueState.loading;
  bool get hasData =>
      songsState != null && songsState!.state == AsyncValueState.success;

  void fetchSong() async {
    try {
      // 1- loading state
      songsState = AsyncValue.loading();
      notifyListeners();
      // 2 - Fetch users
      songsState = AsyncValue.success(await _repository.getSongs());
      print("SUCCESS: list size ${songsState!.data!.length.toString()}");
      // 3 - Handle errors
    } catch (error) {
      print("ERROR: $error");
      songsState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addSong(String title, String artis, String album) async {
    // 1- Call repo to add
    await _repository.addSong(title: title, artist: artis, album: album);
    // 2- Call repo to fetch
    fetchSong();
  }

  void deleteSong(String id) async {
    // 1- Call repo to delete
    await _repository.deleteSong(id);

    // 2- Call repo to fetch
    fetchSong();
  }

  void updateSong(Song song) async {
    // 1- Call repo to update
    await _repository.updateSong(song);

    // 2- Call repo to fetch
    fetchSong();
  }
}
