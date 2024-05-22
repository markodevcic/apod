import 'package:apod/modules/home/view/home_page.dart';
import 'package:apod/utilities/constants/custom_color.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
                    OrientationBuilder(builder: (context, orientation) {
                      return Hero(
                        tag: 'title',
                        child: Material(
                          color: Colors.transparent,
                          child: Align(
                            alignment: orientation == Orientation.portrait
                                ? Alignment.topCenter
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.1,
                                left: 96,
                                right: orientation == Orientation.portrait
                                    ? 96
                                    : MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Animate(
                                onComplete: (_) {
                                  context.pushReplacement(
                                    const HomePage(),
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
                                      context.textTheme.titleMedium!.copyWith(
                                    color:
                                        CustomColor.lunarWhite.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                )
              : const SizedBox.shrink()),
    );
  }
}
