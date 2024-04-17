import 'package:apod/shared/widgets/animated/animated_ttitle.dart';
import 'package:apod/shared/widgets/loaders/loader.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class LoaderWithText extends Loader {
  const LoaderWithText({super.key, super.size, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        super.build(context),
        if (text != null)
          Padding(
            padding: const EdgeInsets.only(right: 108, left: 108, top: 32),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: AnimatedTitle(
                key: UniqueKey(),
                title: text!,
                style: context.textTheme.bodySmall,
                wrapAlignment: WrapAlignment.center,
              ),
            ),
          ),
      ],
    );
  }
}
