import 'faculty.dart';

enum GenderType { male, female }

class StudentProfile {
  final String firstName;
  final String lastName;
  final Faculty faculty;
  final int grade;
  final GenderType gender;

  const StudentProfile({
    required this.firstName,
    required this.lastName,
    required this.faculty,
    required this.grade,
    required this.gender,
  });
}
