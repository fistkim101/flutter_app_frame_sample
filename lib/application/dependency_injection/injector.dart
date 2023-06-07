import 'package:app_frame_sample/application/application.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';

import '../../barrel.dart';

class Injector {
  Injector._();

  static GetIt get _instance => GetIt.instance;

  static DeviceInfoPlugin get deviceInfoPlugin =>
      _instance.get<DeviceInfoPlugin>();

  static Future prepareDependencies() async {
    _prepareUtils();
    _prepareNetworks();
  }

  static void _prepareUtils() {
    _instance.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());
  }

  static void _prepareNetworks() {
    _instance.registerLazySingleton(
      () => TodoApiClient(
        clientBaseUrl: Environment.baseUrl,
        customInterceptors: [BaseHeaderInterceptor()],
      ),
    );
  }
}
