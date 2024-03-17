import 'package:apod/constants/app_color.dart';
import 'package:apod/modules/image_of_the_day/image_of_the_day.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      setState(() => showImage = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: showImage
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.2,
                        ),
                        child: Hero(
                          tag: 'splash',
                          child: Image.asset(
                            'assets/background.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'title',
                      child: Material(
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                              left: 80,
                              right: 80,
                            ),
                            child: Animate(
                              // delay: 500.ms,
                              onComplete: (_) {
                                context.pushReplacement(
                                  const ImageOfTheDay(),
                                  transitionDuration:
                                      const Duration(seconds: 1),
                                );
                              },
                              effects: [
                                FadeEffect(
                                  begin: 0,
                                  end: 1,
                                  duration: 500.ms,
                                ),
                                BlurEffect(
                                  curve: Curves.easeInOut,
                                  delay: 500.ms,
                                  begin: const Offset(10, 10),
                                  end: const Offset(0, 0),
                                  duration: 1000.ms,
                                )
                              ],
                              child: Text(
                                'Astronomy Picture of the Day',
                                textAlign: TextAlign.center,
                                style:
                                    context.textTheme.headlineSmall!.copyWith(
                                  color: AppColor.lunarWhite.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink()),
    );
  }
}
