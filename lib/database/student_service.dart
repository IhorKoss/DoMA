import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  static const String baseUrl = 'http://192.168.0.202:3000/students';

  static Future<Map<String, dynamic>> getStudentById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch student: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> updateStudentById(String id, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to update student: ${response.body}');
    }
  }

  // static Future<void> deleteStudentById(String id) async {
  //   final response = await http.delete(
  //     Uri.parse('$baseUrl/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to delete student: ${response.body}');
  //   }
  // }
}
