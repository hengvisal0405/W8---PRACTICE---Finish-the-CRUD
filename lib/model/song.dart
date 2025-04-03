class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
  });
  @override
  bool operator ==(Object other) {
    return other is Song && other.title == title;
  }

  @override
  int get hashCode => super.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'Song(title: $title, artist: $artist, album: $album)';
  }
}
