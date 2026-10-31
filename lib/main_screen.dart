import 'package:cards_against_showdown/cards_loader.dart';
import 'package:cards_against_showdown/game_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';

/// The main screen of the application.
class MainScreen extends StatelessWidget {
  /// Create an instance.
  const MainScreen({super.key});

  /// Build the widget.
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      RendererBinding.instance.ensureSemantics();
    }
    return CardsLoader(builder: (cards) => GameScreen(cards: cards));
  }
}
