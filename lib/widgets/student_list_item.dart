import 'package:flutter/material.dart';
import '../models/student_profile.dart';
import '../models/faculty_icons.dart';
import '../models/faculty_names.dart';

class StudentListItem extends StatelessWidget {
  final StudentProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentListItem({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor =
        profile.gender == Gender.male ? Colors.blueAccent.shade100 : Colors.pinkAccent.shade100;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_note, color: Colors.indigo),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.school, color: Colors.grey.shade700, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      facultyNames[profile.faculty]!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${profile.grade}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: profile.gender == Gender.male ? Colors.blue : Colors.pink,
                width: 2,
              ),
            ),
            child: Icon(
              facultyIcons[profile.faculty],
              size: 30,
              color: profile.gender == Gender.male ? Colors.blue : Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
