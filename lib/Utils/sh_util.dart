import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._();
  SharedPref._();
  factory SharedPref() => instance;
  static SharedPreferences? _prefs;
  final String isUserLoggedin = "isUserLoggedin";

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setIsUserLoggedIn(bool isUserLoggedIn) async {
    try {
      await _prefs?.setBool(isUserLoggedin, isUserLoggedIn);
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  getISUserLoggedIn() {
    try {
      return _prefs?.getBool(isUserLoggedin) ?? false;
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  clear() async {
    // await _prefs?.remove();
  }
}
