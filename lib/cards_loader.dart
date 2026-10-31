import 'package:backstreets_widgets/screens.dart';
import 'package:cards_against_showdown/async_value_builder.dart';
import 'package:cards_against_showdown/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// A widget which loads cards and passes them to [builder].
class CardsLoader extends ConsumerWidget {
  /// Create an instance.
  const CardsLoader({required this.builder, super.key});

  /// The builder to use.
  final Widget Function(List<String> cards) builder;

  /// Build the widget.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(cardsProvider(DefaultAssetBundle.of(context)));
    return AsyncValueBuilder(
      value: value,
      builder: builder,
      error: ErrorScreen.withPositional,
      loading: LoadingScreen.new,
    );
  }
}
