import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  //private constuctor
  SharedPref._();
  //static instance of the class
  static SharedPref instance = SharedPref._();
  factory SharedPref() => instance;
  static SharedPreferences? _prefs;
  final String isUserLoggedin = "isUserLoggedin";
  final String userEmailKey = "email";
  final String userPasswordKey = "password";
  //static method to acces the instance
  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setUserEmail({String? userEmail}) async {
    try {
      await _prefs?.setString(userEmailKey, userEmail ?? "");
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  getUserEmail() {
    try {
      return _prefs?.getString(userEmailKey);
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  setUserPassword({String? userPassword}) async {
    try {
      await _prefs?.setString(userPasswordKey, userPassword ?? "");
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  getUserPassword() {
    try {
      return _prefs?.getString(userPasswordKey);
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  setIsUserLoggedIn(bool isUserLoggedIn) async {
    try {
      await _prefs?.setBool(isUserLoggedin, isUserLoggedIn);
    } on Exception catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  getIsUserLoggedIn() {
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
