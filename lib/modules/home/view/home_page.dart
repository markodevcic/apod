import 'package:apod/modules/home/view/widgets/app_title.dart';
import 'package:apod/modules/home/view/widgets/background_logo_image.dart';
import 'package:apod/modules/home/view/widgets/explore_images_options.dart';
import 'package:apod/modules/home/view/widgets/settings_button.dart';
import 'package:apod/modules/home/providers/today_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _ImageOfTheDayState();
}

class _ImageOfTheDayState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(getTodayImageProvider);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundLogoImage(),
          ExploreImagesOptions(),
          AppTitle(),
          SettingsButton(),
        ],
      ),
    );
  }
}
