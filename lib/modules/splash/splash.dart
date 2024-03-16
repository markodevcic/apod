import 'package:apod/modules/image_of_the_day/image_of_the_day.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool showImage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => showImage = true);
      await Future.delayed(const Duration(seconds: 3));
      context.pushReplacement(const ImageOfTheDay());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: showImage
                ? Hero(
                    tag: 'splash',
                    child: Image.asset(
                      'assets/background.png',
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
