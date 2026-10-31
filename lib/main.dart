import 'package:cards_against_showdown/main_screen.dart';
import 'package:flutter_audio_games/flutter_audio_games.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// The top-level app class.
class MyApp extends StatelessWidget {
  /// Create an instance.
  const MyApp({super.key});

  /// Build the widget.
  @override
  Widget build(BuildContext context) => SoLoudScope(
    child: MaterialApp(
      title: 'Cards Against Showdown',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MainScreen(),
    ),
  );
}
