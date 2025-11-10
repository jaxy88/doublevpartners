import 'package:shared_preferences/shared_preferences.dart';

class InfoId {
  Future<void> saveUserI(var id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}
