import 'package:flutter/material.dart';
import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';
import '../models/faculty.dart';
import '../models/faculty_icons.dart';
import '../models/faculty_names.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';

class CurrentStudent extends ConsumerStatefulWidget {
  const CurrentStudent({
    super.key,
    this.studentIndex
  });

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentStudentState();
}

class _CurrentStudentState extends ConsumerState<CurrentStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Faculty _selectedFaculty = Faculty.law;
  Gender _selectedGender = Gender.male;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(provider).studentList[widget.studentIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _selectedGender = student.gender;
      _selectedFaculty = student.faculty;
      _grade = student.grade;
    }
  }

  void submit() async {
      if (widget.studentIndex == null)  {
      await ref.read(provider.notifier).addEntry(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedFaculty,
            _selectedGender,
            _grade,
          );
    } else {
      await ref.read(provider.notifier).editEntry(
            widget.studentIndex!,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedFaculty,
            _selectedGender,
            _grade,
          );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop();  
}

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(provider);
    if (students.loading) {
      return const Center(child: CircularProgressIndicator());
    }
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
                    _selectedFaculty = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: Gender.values
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Row(
                            children: [
                              Icon(
                                gender == Gender.male ? Icons.male : Icons.female,
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
                    _selectedGender = value!;
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
                    onPressed: submit,
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
