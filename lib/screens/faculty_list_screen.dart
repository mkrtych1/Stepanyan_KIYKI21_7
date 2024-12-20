import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/faculty.dart';
import '../providers/students_provider.dart';
import '../widgets/faculty_card.dart';
import '../models/faculty_names.dart';

class FacultyListScreen extends ConsumerWidget {
  const FacultyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(provider);

    final facultyCounts = {
      for (var faculty in Faculty.values)
        faculty: students.where((s) => s.faculty == faculty).length,
    };

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: Faculty.values.length,
      itemBuilder: (context, index) {
        final faculty = Faculty.values[index];

        return FacultyCard(
          faculty: faculty,
          studentCount: facultyCounts[faculty] ?? 0,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${facultyNames[faculty]} details will be available soon!',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.teal,
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }
}
