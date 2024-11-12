import 'package:flutter/material.dart';
import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';

class StudentListItem extends StatelessWidget {
  final StudentProfile profile;

  const StudentListItem({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color cardColor = profile.gender == GenderType.male ? Colors.lightBlue[50]! : Colors.orange[50]!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        title: Text(
          '${profile.firstName} ${profile.lastName}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Grade: ${profile.grade}',
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            facultyIcons[profile.faculty],
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
