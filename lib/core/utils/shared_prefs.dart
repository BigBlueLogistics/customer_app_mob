import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPrefs] uses singleton pattern
/// to reuse the [SharedPreferences] instances
class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  // factory constructor
  factory SharedPrefs() {
    return _instance;
  }

  // private named constructor
  SharedPrefs._internal();

  // Instiantiate the shared preferences
  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  // Get API token
  static void setApiToken(String value) {
    _sharedPrefs?.setString('apiToken', value);
  }

  // Set API token
  static String? getApiToken() {
    return _sharedPrefs?.getString('apiToken');
  }
}
