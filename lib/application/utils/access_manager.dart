import 'package:shared_preferences/shared_preferences.dart';

class AccessManager {
  static const String accessTokenKey = 'accessToken';

  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(accessTokenKey, accessToken);
  }

  static Future<String> getAccessToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? accessToken = preferences.getString(accessTokenKey);
    if (accessToken == null) {
      return '';
    }
    
    return accessToken;
  }
}
