import 'package:apod/modules/image_of_the_day/widgets/app_title.dart';
import 'package:apod/modules/image_of_the_day/widgets/background_logo_image.dart';
import 'package:apod/modules/image_of_the_day/widgets/menu_section.dart';
import 'package:apod/providers/today_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageOfTheDay extends ConsumerStatefulWidget {
  const ImageOfTheDay({super.key});

  @override
  ConsumerState<ImageOfTheDay> createState() => _ImageOfTheDayState();
}

class _ImageOfTheDayState extends ConsumerState<ImageOfTheDay> {
  @override
  void initState() {
    super.initState();
    ref.read(todayImageProvider.notifier).get();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundLogoImage(),
          MenuSection(),
          AppTitle(),
        ],
      ),
    );
  }
}
