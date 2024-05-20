import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  void setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("x-auth-token", token);
  }

  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("x-auth-token");
  }
}
