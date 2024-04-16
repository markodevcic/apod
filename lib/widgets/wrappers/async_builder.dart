import 'package:apod/widgets/loaders/async_loader_with_retry.dart';
import 'package:apod/widgets/loaders/loader_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncBuilder extends StatelessWidget {
  const AsyncBuilder({
    super.key,
    required this.builder,
    this.await,
    this.onRetryTap,
    this.loadingMessage,
    this.animationTime = 300,
  });

  final Widget Function(Object?) builder;
  final AsyncValue? await;
  final Function? onRetryTap;
  final String? loadingMessage;
  final int animationTime;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: animationTime),
        switchInCurve: Curves.easeInOutQuad,
        child: await?.when(
          data: (data) => builder(data),
          error: (_, __) => AsyncLoaderWithRetry(onRetryTap: onRetryTap),
          loading: () => LoaderWithText(
            text: loadingMessage ?? 'Loading',
          ),
        ),
      ),
    );
  }
}
