import 'dart:math';

import 'package:backstreets_widgets/screens.dart';
import 'package:cards_against_showdown/gen/assets.gen.dart';
import 'package:flutter_audio_games/flutter_audio_games.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final _random = Random();

/// The main game screen.
class GameScreen extends ConsumerStatefulWidget {
  /// Create an instance.
  const GameScreen({required this.cards, super.key});

  /// The cards to use.
  final List<String> cards;

  /// Create state for this widget.
  @override
  GameScreenState createState() => GameScreenState();
}

/// State for [GameScreen].
class GameScreenState extends ConsumerState<GameScreen> {
  /// The unplayed cards.
  late final List<String> unplayedCards;

  /// The played cards.
  late final List<String> playedCards;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    unplayedCards = [...widget.cards];
    playedCards = [];
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build a widget.
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      height: 1.3,
    );
    if (playedCards.isEmpty) {
      return SimpleScaffold(
        title: 'Start Game',
        body: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24, 32, 24, 96),
            child: Text('No card has been drawn yet.', style: style),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: drawCard,
          autofocus: true,
          tooltip: 'Draw your first card',
          key: const ValueKey('start-game'),
          label: const Text(
            'Draw card',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    final card = playedCards.last;
    return SimpleScaffold(
      actions: [
        IconButton(
          onPressed: shuffleCards,
          icon: const Icon(Icons.shuffle),
          tooltip: 'Shuffle cards',
        ),
      ],
      title: 'Card ${playedCards.length} / ${widget.cards.length}',
      body: Semantics(
        label: card,
        child: Focus(
          autofocus: true,
          key: const ValueKey('card-area'),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 96),
              child: SizedBox(
                width: double.infinity,
                child: Semantics(
                  liveRegion: true,
                  child: Text(
                    card,
                    style: style,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: drawCard,
        label: const Text(
          'Draw another card',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        tooltip: 'Draw another card',
        key: const ValueKey('draw-card'),
      ),
    );
  }

  /// Draw a card.
  void drawCard() {
    context.playSound(Assets.drawCard.asSound(destroy: false));
    if (unplayedCards.isEmpty) {
      playedCards.clear();
      unplayedCards.addAll(widget.cards);
    }
    final int cardIndex;
    if (unplayedCards.length == 1) {
      cardIndex = 0;
    } else {
      cardIndex = _random.nextInt(unplayedCards.length);
    }
    setState(() {
      playedCards.add(unplayedCards.removeAt(cardIndex));
    });
  }

  /// Shuffle the cards.
  void shuffleCards() {
    context.playSound(Assets.shuffleCards.asSound(destroy: false));
    setState(() {
      unplayedCards.clear();
      playedCards.clear();
      unplayedCards.addAll(widget.cards);
    });
  }
}
