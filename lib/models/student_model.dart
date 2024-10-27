import 'package:flutter/material.dart';

class Student with ChangeNotifier {
  String _email;
  String _password;
  String _studentId;
  String _group;
  String _fullName;
  bool _isFullTimeStudent;

  Student({
    String email = '',
    String password = '',
    String studentId = '',
    String fullName = '',
    String group = '',
    bool isFullTimeStudent = true,
  })  :
        _email = email,
        _fullName = fullName,
        _group = group,
        _password = password,
        _studentId = studentId,
        _isFullTimeStudent = isFullTimeStudent;

  String get email => _email;
  String get fullName => _fullName;
  String get group => _group;
  String get studentId => _studentId;
  bool get isFullTimeStudent => _isFullTimeStudent;

  void setNewStudent({
    required String email,
    required String password,
    required String studentId,
  }) {
    _email = email;
    _password = password;
    _studentId = studentId;
    notifyListeners();
  }
  void setLoggedInStudent({
    required String email,
    required String password,
    required String studentId,
    String? fullName,
    String? group,
    bool? isFullTimeStudent,
  }) {
    _email = email;
    _password = password;
    _studentId = studentId;
    _fullName = fullName ?? '';
    _group = group ?? '';
    _isFullTimeStudent = isFullTimeStudent ?? true;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setFullName(String fullName) {
    _fullName = fullName;
    notifyListeners();
  }

  void setGroup(String group) {
    _group = group;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setStudentId(String studentId) {
    _studentId = studentId;
    notifyListeners();
  }

  void setIsFullTimeStudent(bool isFullTimeStudent) {
    _isFullTimeStudent = isFullTimeStudent;
    notifyListeners();
  }

  bool get hasData {
    return _email.isNotEmpty &&
        _password.isNotEmpty &&
        _studentId.isNotEmpty;
  }

  void logOutStudent()
  {
    _email = '';
    _password = '';
    _studentId = '';
    _fullName = '';
    _group = '';
    _isFullTimeStudent = true;
    notifyListeners();
  }
}
