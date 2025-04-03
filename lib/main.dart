import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/repository/firebase/song_firebase_repository.dart';
import 'package:my_app/data/repository/song_repository.dart';
import 'package:my_app/ui/provider/firstbase_options.dart';
import 'package:my_app/ui/provider/song_provider.dart';
import 'package:my_app/ui/screen/home_page.dart';
import 'package:provider/provider.dart';

// 5 - MAIN
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 1 - Create repository
  final SongRepository songRepository = FirebaseSongRepository();
  // 2-  Run app
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongProvider(songRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    ),
  );
}
