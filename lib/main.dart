import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/modules/image_of_the_day/image_of_the_day.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astronomy Picture of the Day',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.cosmicBlue,
            brightness: Brightness.dark,
          ),
          splashFactory: NoSplash.splashFactory,
          highlightColor: AppColor.lunarWhite.withOpacity(0.2),
          useMaterial3: true,
          textTheme: TextTheme(
            headlineSmall: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.gruppo().fontFamily,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.gruppo().fontFamily,
            ),
            titleSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.gruppo().fontFamily,
            ),
            bodyMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.gruppo().fontFamily,
              height: 1.5,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.gruppo().fontFamily,
              height: 1.5,
            ),
          ),
          scaffoldBackgroundColor: AppColor.deepSpaceBlack),
      home: const ImageOfTheDay(),
    );
  }
}
