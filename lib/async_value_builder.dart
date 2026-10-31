import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Returns a [builder] when the given [value] has data.
class AsyncValueBuilder<T> extends StatelessWidget {
  /// Create an instance.
  const AsyncValueBuilder({
    required this.value,
    required this.builder,
    this.loading = LoadingWidget.new,
    this.error = ErrorListView.withPositional,
    super.key,
  });

  /// The value to work with.
  final AsyncValue<T> value;

  /// The builder to use.
  final Widget Function(T data) builder;

  /// The function to call to show a loading widget.
  final Widget Function() loading;

  /// The function to call to show an error widget.
  final Widget Function(Object error, StackTrace stackTrace) error;

  /// Build the widget.
  @override
  Widget build(BuildContext context) {
    final localValue = value;
    return switch (localValue) {
      AsyncLoading<T>() => loading(),
      AsyncData<T>() => builder(localValue.value),
      AsyncError<T>() => error(localValue.error, localValue.stackTrace),
    };
  }
}
