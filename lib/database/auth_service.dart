import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://192.168.0.202:3000/auth';

  static Future<Map<String, dynamic>> register(String email, String password, String studentId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'studentId': studentId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)  as Map<String, dynamic>;
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)  as Map<String, dynamic>;
    } else {
      return null;
    }
  }
}
