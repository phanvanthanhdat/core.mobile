import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<Map<String, dynamic>> readObject(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String jsonEncode = prefs.getString(key);
      return json.decode(jsonEncode) as Map<String, dynamic>;
    } catch (err) {
      return null;
    }
  }

  static Future<bool> writeObject(String key, Map<String, dynamic> jsonObject) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(key, json.encode(jsonObject));
      return true;
    } catch (err) {
    }
    return false;
  }

  static Future<bool> writeList(String key, List list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(key, json.encode(list));
      return true;
    } catch (err) {
    }
    return false;
  }

  static Future<List> readList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String jsonEncode = prefs.getString(key);
      return json.decode(jsonEncode) as List;
    } catch (err) {
      return null;
    }
  }

  static Future<bool> delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(key);
      return true;
    } catch (err) {
      return false;
    }
  }
}