import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  String key;
  String val;

  static addStringToSP(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  static Future<String> getStringFromSP(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String val = await prefs.getString(key);
    return val;
  }
}
