import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncLoaderWithRetry extends ConsumerWidget {
  const AsyncLoaderWithRetry({super.key, required this.provider});

  final AutoDisposeFutureProvider<dynamic> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Could not load data',
                style: context.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              AppOutlinedButton(
                onPressed: () async {
                  try {
                    return await ref.refresh(provider.future);
                  } catch (_) {}
                },
                title: 'Retry',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
