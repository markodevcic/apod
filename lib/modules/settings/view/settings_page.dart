import 'package:apod/modules/settings/view/widgets/clear_image_cache.dart';
import 'package:apod/modules/settings/view/widgets/color_settings.dart';
import 'package:apod/modules/settings/view/widgets/list_layout_settings.dart';
import 'package:apod/shared/widgets/wrappers/page_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      title: 'Settings',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColorSettings(),
            ListLayoutSettings(),
            ClearImageCache(),
          ],
        ),
      ),
    );
  }
}
