import 'package:app_frame_sample/data/network/client/base_http_client.dart';

class TodoApiClient extends BaseHttpClient {
  TodoApiClient({
    required super.clientBaseUrl,
    required super.customInterceptors,
    super.customOptions,
  });
}
