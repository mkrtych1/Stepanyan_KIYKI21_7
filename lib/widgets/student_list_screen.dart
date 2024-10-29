import 'package:flutter/material.dart';
import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';
import 'package:stepanyan_kiuki_21_7/widgets/student_list_item.dart';

class StudentListScreen extends StatelessWidget {
  final List<StudentProfile> students;

  const StudentListScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profiles', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lightGreenAccent,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentListItem(profile: students[index]);
        },
      ),
    );
  }
}
