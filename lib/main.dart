import 'package:apod/modules/splash/splash.dart';
import 'package:apod/services/storage/shared_prefs.dart';
import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await dotenv.load();
  await SharedPrefs.initializePrefs();

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
        fontFamily: GoogleFonts.interTight().fontFamily,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            height: 1.5,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        scaffoldBackgroundColor: AppColor.deepSpaceBlack,
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: ref.watch(appColorProvider).withOpacity(0.6),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
