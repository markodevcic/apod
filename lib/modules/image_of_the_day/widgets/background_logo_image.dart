import 'package:flutter/material.dart';

class BackgroundLogoImage extends StatelessWidget {
  const BackgroundLogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'splash',
      child: Image.asset(
        'assets/background.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
