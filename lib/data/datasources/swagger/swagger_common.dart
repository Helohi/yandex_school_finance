import 'package:flutter_dotenv/flutter_dotenv.dart';

class SwaggerCommon {
  static final baseUrl = "https://shmr-finance.ru/api/v1";
  static final authHeader = <String, String>{
    "Authorization": "Bearer ${dotenv.env["TOKEN"]}",
  };
}
