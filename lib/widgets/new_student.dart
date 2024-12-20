import 'package:flutter/material.dart';
import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';

class NewStudent extends StatefulWidget {
  final StudentProfile? student;
  final Function(StudentProfile) onSave;

  const NewStudent({Key? key, this.student, required this.onSave}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Faculty? _selectedFaculty;
  GenderType? _selectedGender;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedFaculty = widget.student!.faculty;
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              DropdownButtonFormField<Faculty>(
                value: _selectedFaculty,
                decoration: const InputDecoration(labelText: 'Faculty'),
                items: Faculty.values
                    .map((faculty) => DropdownMenuItem(
                          value: faculty,
                          child: Text(faculty.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFaculty = value;
                  });
                },
              ),
              DropdownButtonFormField<GenderType>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: GenderType.values
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Slider(
                value: _grade.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: _grade.toString(),
                onChanged: (value) {
                  setState(() {
                    _grade = value.toInt();
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final newStudent = StudentProfile(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        faculty: _selectedFaculty!,
                        grade: _grade,
                        gender: _selectedGender!,
                      );
                      widget.onSave(newStudent);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
