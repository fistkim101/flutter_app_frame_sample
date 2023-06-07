import 'package:dio/dio.dart';

abstract class BaseHttpClient with DioMixin implements Dio {
  final String clientBaseUrl;
  final List<Interceptor> customInterceptors;
  BaseOptions? customOptions;

  BaseHttpClient({
    required this.clientBaseUrl,
    required this.customInterceptors,
    this.customOptions,
  }) {
    if (customOptions != null) {
      options = customOptions!;
    }
    options.baseUrl = clientBaseUrl;
    // options.connectTimeout = Duration(seconds: 5);
    // options.receiveTimeout = Duration(seconds: 3);
    interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    interceptors.addAll(customInterceptors);
  }
}
