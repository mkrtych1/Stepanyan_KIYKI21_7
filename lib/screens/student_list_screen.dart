import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student_profile.dart';
import '../providers/students_provider.dart';
import '../widgets/current_student.dart';
import '../widgets/student_list_item.dart';

class StudentListScreen extends ConsumerWidget {
  const StudentListScreen({super.key});

  void _showAddOrEditModal(BuildContext context, WidgetRef ref,
      {StudentProfile? student, int? index}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return CurrentStudent(
          student: student,
          onSave: (newStudent) {
            if (index != null) {
              ref.read(provider.notifier).updateEntry(index, newStudent);
            } else {
              ref.read(provider.notifier).addEntry(newStudent);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Students',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: students.isEmpty
          ? const Center(
              child: Text(
                'No students yet!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return StudentListItem(
                  profile: student,
                  onEdit: () =>
                      _showAddOrEditModal(context, ref, student: student, index: index),
                  onDelete: () {
                    ref.read(provider.notifier).removeEntry(index);
                    final toUndo = ProviderScope.containerOf(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${student.firstName} removed.'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            toUndo.read(provider.notifier).restoreEntry();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => _showAddOrEditModal(context, ref),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
