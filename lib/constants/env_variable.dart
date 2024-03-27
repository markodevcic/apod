import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariable {
  static String apiKey = dotenv.get('API_KEY');
}
