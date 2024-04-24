import 'package:apod/shared/widgets/loaders/async_loader_with_retry.dart';
import 'package:apod/shared/widgets/loaders/loader_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncBuilder<T> extends ConsumerWidget {
  const AsyncBuilder({
    super.key,
    required this.provider,
    required this.builder,
    this.loadingText,
    this.animationTime = 200,
  });

  final AutoDisposeFutureProvider<dynamic> provider;
  final Widget Function(T) builder;
  final String? loadingText;
  final int animationTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(provider);

    return Material(
      color: Colors.transparent,
      child: AnimatedSize(
        duration: Duration(milliseconds: animationTime),
        curve: Curves.decelerate,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: animationTime * 2),
          switchInCurve: Curves.easeInOutQuad,
          child: future.when(
            data: (data) => builder(data),
            error: (_, __) => AsyncLoaderWithRetry(provider: provider),
            loading: () => Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LoaderWithText(text: loadingText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
