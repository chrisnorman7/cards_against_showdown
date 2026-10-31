import 'dart:convert';

import 'package:cards_against_showdown/gen/assets.gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Provide the list of cards.
final cardsProvider = FutureProvider.family<List<String>, AssetBundle>((
  ref,
  bundle,
) async {
  final data = await bundle.loadString(Assets.cards);
  return const LineSplitter().convert(data);
});
