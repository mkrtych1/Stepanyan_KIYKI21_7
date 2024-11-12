import 'package:flutter/material.dart';
import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';
import 'package:stepanyan_kiuki_21_7/widgets/student_list_item.dart';
import 'package:stepanyan_kiuki_21_7/widgets/new_student.dart';

class StudentListScreen extends StatefulWidget {
  final List<StudentProfile> students;

  const StudentListScreen({Key? key, required this.students}) : super(key: key);

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late List<StudentProfile> students;
  StudentProfile? _lastDeletedStudent;
  int? _lastDeletedIndex;

  @override
  void initState() {
    super.initState();
    students = widget.students;
  }

  void _addOrEditStudent({StudentProfile? student, int? index}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NewStudent(
          student: student,
          onSave: (newStudent) {
            setState(() {
              if (index != null) {
                students[index] = newStudent;
              } else {
                students.add(newStudent);
              }
            });
          },
        );
      },
    );
  }

  void _deleteStudent(int index) {
    setState(() {
      _lastDeletedStudent = students[index];
      _lastDeletedIndex = index;
      students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_lastDeletedStudent!.firstName} has been deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: _undoDelete,
        ),
      ),
    );
  }

  void _undoDelete() {
    if (_lastDeletedStudent != null && _lastDeletedIndex != null) {
      setState(() {
        students.insert(_lastDeletedIndex!, _lastDeletedStudent!);
      });
      _lastDeletedStudent = null;
      _lastDeletedIndex = null;
    }
  }

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
          return Dismissible(
            key: ValueKey(students[index]),
            background: Container(color: Colors.red),
            onDismissed: (direction) => _deleteStudent(index),
            child: InkWell(
              onTap: () => _addOrEditStudent(student: students[index], index: index),
              child: StudentListItem(profile: students[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditStudent(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
