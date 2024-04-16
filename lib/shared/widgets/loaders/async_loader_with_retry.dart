import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/shared/widgets/loaders/loader_with_text.dart';
import 'package:flutter/material.dart';

class AsyncLoaderWithRetry extends StatelessWidget {
  const AsyncLoaderWithRetry({super.key, this.onRetryTap, this.loadingMessage});

  final Function? onRetryTap;
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: onRetryTap != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Refreshing data failed',
                      style: context.textTheme.bodyMedium,
                    ),
                    TextButton(
                      child: Text(
                        'Retry',
                        style: context.textTheme.labelSmall,
                      ),
                      onPressed: () => onRetryTap!(),
                    ),
                  ],
                )
              : LoaderWithText(
                  text: loadingMessage ?? 'Refreshing',
                ),
        ),
      ),
    );
  }
}
