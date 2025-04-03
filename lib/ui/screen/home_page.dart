import 'package:flutter/material.dart';
import 'package:my_app/model/song.dart';
import 'package:my_app/ui/screen/add_song_form.dart';
import 'package:provider/provider.dart';
import '../provider/song_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    Widget content = const Text('');
    if (songProvider.isLoading) {
      content = const CircularProgressIndicator();
    } else if (songProvider.hasData) {
      List<Song> songs = songProvider.songsState!.data!;

      if (songs.isEmpty) {
        content = const Center(
          child: Text(
            "No songs yet",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      } else {
        content = ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                songs[index].title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'by ${songs[index].artist} - album ${songs[index].album}', // Display artist and album
                style: const TextStyle(color: Colors.red),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => songProvider.deleteSong(songs[index].id),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSongForm(
                    mode: EditingMode.editProduct,
                    song: songs[index],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } else if (songProvider.songsState?.error != null) {
      content = Center(
        child: Text(
          'Error: ${songProvider.songsState?.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Song App", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AddSongForm(mode: EditingMode.addProduct),
              ),
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
