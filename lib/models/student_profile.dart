import 'package:flutter/material.dart';
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

enum Faculty { economics, law, technology, healthSciences }
enum GenderType { male, female }

const Map<Faculty, IconData> facultyIcons = {
  Faculty.economics: Icons.monetization_on,
  Faculty.law: Icons.account_balance,
  Faculty.technology: Icons.computer,
  Faculty.healthSciences: Icons.local_hospital,
};
