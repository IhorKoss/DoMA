import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static Future<void> saveLoggedStudent(Map<String, dynamic> studentData) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentJson = jsonEncode(studentData);
    await prefs.setString('loggedStudent', studentJson);
  }

  static Future<Map<String, dynamic>?> getLoggedStudent() async {
    // await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final String? studentJson = prefs.getString('loggedStudent');
    if (studentJson != null) {
      return jsonDecode(studentJson) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<void> clearLoggedStudent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
