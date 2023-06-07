import 'package:app_frame_sample/app.dart';
import 'package:flutter/cupertino.dart';

import '../application.dart';

class Environment {
  static Environment? _instance;
  final EnvironmentType environmentType;

  const Environment._internal(this.environmentType);

  static bool get _isDevelopment {
    return _instance!.environmentType == EnvironmentType.development;
  }

  static bool get _isProduction {
    return _instance!.environmentType == EnvironmentType.production;
  }

  static String get baseUrl {
    if (_isDevelopment) {
      return 'http://localhost:8080';
    }

    if (_isProduction) {
      return 'http://localhost:8080';
    }

    throw UnsupportedError(ErrorMessage.notFoundEnvironmentType);
  }

  factory Environment.newInstance(EnvironmentType environmentType) {
    _instance ??= Environment._internal(environmentType);
    return _instance!;
  }

  void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Injector.prepareDependencies();
    runApp(const Application());
  }
}
