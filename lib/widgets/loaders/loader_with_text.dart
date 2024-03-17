import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/loaders/loader.dart';
import 'package:apod/widgets/texts/animated_ttitle.dart';
import 'package:flutter/material.dart';

class LoaderWithText extends Loader {
  const LoaderWithText({super.key, super.size, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        super.build(context),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 92),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: AnimatedTitle(
              key: UniqueKey(),
              title: text,
              style: context.textTheme.titleMedium,
              wrapAlignment: WrapAlignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
