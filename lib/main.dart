import 'package:apod/utilities/constants/app_color.dart';
import 'package:apod/modules/splash/splash.dart';
import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await dotenv.load();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astronomy Picture of the Day',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
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
        scaffoldBackgroundColor: AppColor.deepSpaceBlack,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.gruppo().fontFamily,
          ),
          elevation: 0,
          backgroundColor: ref.watch(appColorProvider).withOpacity(0.6),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
