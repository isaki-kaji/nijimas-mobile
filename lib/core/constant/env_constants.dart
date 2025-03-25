import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String baseUrl = dotenv.get("BASE_URL");
}
