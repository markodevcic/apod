import 'dart:ui';

import 'package:apod/modules/home/providers/today_image_provider.dart';
import 'package:apod/modules/image_list/shared/providers/page_list_view_provider.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageWrapper extends ConsumerWidget {
  const PageWrapper({
    super.key,
    required this.body,
    this.title,
    this.actionWidget,
    this.floatingActionWidget,
    this.extendBodyBehindAppBar = false,
  });

  final Widget body;
  final String? title;
  final Widget? actionWidget;
  final Widget? floatingActionWidget;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AppOutlinedButton(
                icon: Icons.arrow_back_ios_rounded,
                onPressed: () {
                  ref.read(todayImageProvider.notifier).get();
                  context.pop();
                },
              ),
            ),
            if (title != null)
              Center(
                child: Text(
                  title!,
                  style: context.textTheme.headlineSmall,
                ),
              ),
            if (actionWidget != null)
              Align(
                alignment: Alignment.centerRight,
                child: actionWidget!,
              ),
          ],
        ),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: body,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppOutlinedButton(
            onPressed: () {
              ref.read(pageListViewDirectionProvider.notifier).setVertical();
            },
            icon: Icons.view_stream_rounded,
          ),
          const SizedBox(width: 8),
          AppOutlinedButton(
            onPressed: () {
              ref.read(pageListViewDirectionProvider.notifier).setHorizontal();
            },
            icon: Icons.view_week_rounded,
          ),
        ],
      ),
    );
  }
}
