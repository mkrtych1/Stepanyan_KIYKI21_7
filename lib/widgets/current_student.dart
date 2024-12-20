import 'package:flutter/material.dart';
import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';
import '../models/faculty.dart';
import '../models/faculty_icons.dart';
import '../models/faculty_names.dart';

class CurrentStudent extends StatefulWidget {
  final StudentProfile? student;
  final Function(StudentProfile) onSave;

  const CurrentStudent({super.key, this.student, required this.onSave});

  @override
  _CurrentStudentState createState() => _CurrentStudentState();
}

class _CurrentStudentState extends State<CurrentStudent> {
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
              const Text(
                'Current Student',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: const Icon(Icons.person, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Faculty>(
                value: _selectedFaculty,
                decoration: InputDecoration(
                  labelText: 'Faculty',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: Faculty.values
                    .map((faculty) => DropdownMenuItem(
                          value: faculty,
                          child: Row(
                            children: [
                              Icon(
                                facultyIcons[faculty],
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 10),
                              Text(facultyNames[faculty]!),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFaculty = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<GenderType>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: GenderType.values
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Row(
                            children: [
                              Icon(
                                gender == GenderType.male ? Icons.male : Icons.female,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 10),
                              Text(gender.name),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Grade:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: _grade.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _grade.toString(),
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      setState(() {
                        _grade = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedFaculty == null || _selectedGender == null) return;

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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
