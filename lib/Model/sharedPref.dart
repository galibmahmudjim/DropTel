import 'package:shared_preferences/shared_preferences.dart';

class sharedPref {
  static var prefs;

  static init() async {
    var prefs1 = await SharedPreferences.getInstance();
    prefs = prefs1;
  }

  static setID(String id) async {
    if (prefs == null) await init();
    await prefs.setString("_id", id);
  }

  static Future<String> getID() async {
    if (prefs == null) await init();
    return await prefs.getString("_id");
  }
}
