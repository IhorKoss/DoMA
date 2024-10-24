class Student {
  final String id;
  final String email;
  final String fullName;
  final String group;
  final String password;
  final String studentId;
  final bool isFullTimeStudent;

  final String createdAt;
  final String? updatedAt;

  Student({
    required this.id,
    required this.email,
    required this.group,
    required this.fullName,
    required this.password,
    required this.studentId,
    required this.isFullTimeStudent,
    required this.createdAt,
    this.updatedAt,
  });
  
  factory Student.fromSqfliteDatabase(Map<String, dynamic> map) =>
      Student(
        id: map['id'] as String? ?? '',
        email: map['email'] as String? ?? '',
        fullName: map['fullName'] as String? ?? '',
        group: map['group'] as String? ?? '',
        password: map['password'] as String? ?? '',
        studentId: map['studentId'] as String? ?? '',
        isFullTimeStudent: map['isFullTimeStudent'] == 1,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            map['createdAt'] as int).toIso8601String(),
        updatedAt: map['updatedAt'] as String? ?? '',
      );
}
