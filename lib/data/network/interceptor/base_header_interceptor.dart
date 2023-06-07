import 'dart:io';

import 'package:app_frame_sample/application/application.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BaseHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await _setHeaderWithAccessToken(options.headers);
    await _setHeaderWithPackageInfo(options.headers);
    await _setHeaderWithDeviceInfo(options.headers);

    super.onRequest(options, handler);
  }

  Future<void> _setHeaderWithAccessToken(Map<String, dynamic> headers) async {
    headers[HttpHeaders.authorizationHeader] =
        await AccessManager.getAccessToken();
  }

  Future<void> _setHeaderWithPackageInfo(Map<String, dynamic> headers) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    headers['appName'] = packageInfo.appName;
    headers['packageName'] = packageInfo.packageName;
    headers['version'] = packageInfo.version;
    headers['buildNumber'] = packageInfo.buildNumber;
  }

  Future<void> _setHeaderWithDeviceInfo(Map<String, dynamic> headers) async {
    final DeviceInfoPlugin deviceInfo = Injector.deviceInfoPlugin;
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      headers['uuid'] = androidInfo.id;
      headers['operatingSystem'] = 'Android';
      headers['operatingSystemVersion'] = androidInfo.version.sdkInt.toString();
      return;
    }

    if (Platform.isIOS) {
      final IosDeviceInfo iOSInfo = await deviceInfo.iosInfo;
      headers['uuid'] = iOSInfo.identifierForVendor;
      headers['operatingSystem'] = 'iOS';
      headers['operatingSystemVersion'] = iOSInfo.systemVersion;
    }
  }
}
