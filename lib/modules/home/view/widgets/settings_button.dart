import 'package:apod/modules/settings/view/settings_page.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 1000.ms,
      effects: [
        FadeEffect(
          duration: 500.ms,
          begin: 0,
          end: 1,
        ),
      ],
      child: OrientationBuilder(builder: (context, orientation) {
        return Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Align(
            alignment: orientation == Orientation.portrait
                ? Alignment.topRight
                : Alignment.topLeft,
            child: AppOutlinedButton(
              onPressed: () => context.push(const SettingsPage()),
              icon: Icons.scatter_plot_rounded,
            ),
          ),
        );
      }),
    );
  }
}
