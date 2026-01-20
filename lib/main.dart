import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yandex_school_finance/core/service_locator.dart' as di;
import 'package:yandex_school_finance/presentation/pages/material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load();
  } on EmptyEnvFileError catch (e) {
    log("Error $e. Is initialized: ${dotenv.isInitialized}");
  }
  await di.init();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(const FinanceApp());
}
