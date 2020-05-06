import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<Set<String>> getKeys() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getKeys();
  }

  static Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> contains(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future<bool> getBool(String key, {defValue = false}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key))
      return preferences.getBool(key) ?? defValue;
    else
      return defValue;
  }

  static Future<bool> setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future<int> getInt(String key, {defValue = 0}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key))
      return preferences.getInt(key) ?? defValue;
    else
      return defValue;
  }

  static Future<bool> setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<String> getString(String key, {defValue = ""}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key))
      return preferences.getString(key) ?? defValue;
    else
      return defValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(key, value);
  }

  static Future<double> getDouble(String key, {defValue = 0.0}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key))
      return preferences.getDouble(key) ?? defValue;
    else
      return defValue;
  }

  static Future<bool> remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key) ?? Future.value(false);
  }

  static Future<bool> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }
}

class Preferences {
  static SharedPreferences _prefsInstance;
  static bool _initialize = false;

  Preferences() {
    init();
  }

  static init() async {
    if (_initialize) {
      return;
    }
    _prefsInstance = await SharedPreferences.getInstance();
    _initialize = true;
  }

  void dispose() {
    _prefsInstance = null;
    _initialize = false;
  }

  _assert() {
    assert(_initialize,
        "Preferences.init() or Preferences() must be called first.");
    assert(_prefsInstance != null, "SharedPreferences not ready yet!");
  }

  Future<Set<String>> getKeys() async {
    _assert();
    return _prefsInstance.getKeys();
  }

  Future<SharedPreferences> getPreferences() async {
    _assert();
    return _prefsInstance;
  }

  Future<bool> contains(String key) async {
    _assert();
    return _prefsInstance.containsKey(key);
  }

  Future<bool> setBool(String key, bool value) async {
    _assert();
    return _prefsInstance.setBool(key, value);
  }

  Future<bool> getBool(String key, {defValue = false}) async {
    _assert();
    if (_prefsInstance.containsKey(key))
      return _prefsInstance.getBool(key) ?? defValue;
    else
      return defValue;
  }

  Future<bool> setInt(String key, int value) async {
    _assert();
    return _prefsInstance.setInt(key, value);
  }

  Future<int> getInt(String key, {defValue = 0}) async {
    _assert();
    if (_prefsInstance.containsKey(key))
      return _prefsInstance.getInt(key) ?? defValue;
    else
      return defValue;
  }

  Future<bool> setString(String key, String value) async {
    _assert();
    return _prefsInstance.setString(key, value);
  }

  Future<String> getString(String key, {defValue = ""}) async {
    _assert();
    if (_prefsInstance.containsKey(key))
      return _prefsInstance.getString(key) ?? defValue;
    else
      return defValue;
  }

  Future<bool> setDouble(String key, double value) async {
    _assert();
    return _prefsInstance.setDouble(key, value);
  }

  Future<double> getDouble(String key, {defValue = 0.0}) async {
    _assert();
    if (_prefsInstance.containsKey(key))
      return _prefsInstance.getDouble(key) ?? defValue;
    else
      return defValue;
  }

  Future<bool> remove(String key) async {
    _assert();
    return _prefsInstance.getBool(key) ?? Future.value(false);
  }

  Future<bool> clear() async {
    _assert();
    return _prefsInstance.clear();
  }
}
