    import 'package:flutter/material.dart';
    import 'package:stepanyan_kiuki_21_7/models/student_profile.dart';
    import 'package:stepanyan_kiuki_21_7/widgets/student_list_screen.dart';

    void main() {
      List<StudentProfile> studentProfiles = [
        const StudentProfile(
          firstName: 'Марина',
          lastName: 'Петренко',
          faculty: Faculty.economics,
          grade: 5,
          gender: GenderType.female,
        ),
        const StudentProfile(
          firstName: 'Олександр',
          lastName: 'Черненко',
          faculty: Faculty.technology,
          grade: 4,
          gender: GenderType.male,
        ),
        const StudentProfile(
          firstName: 'Юлія',
          lastName: 'Лисенко',
          faculty: Faculty.law,
          grade: 3,
          gender: GenderType.female,
        ),
        const StudentProfile(
          firstName: 'Богдан',
          lastName: 'Гончар',
          faculty: Faculty.healthSciences,
          grade: 5,
          gender: GenderType.male,
        ),
        const StudentProfile(
          firstName: 'Оксана',
          lastName: 'Савчук',
          faculty: Faculty.economics,
          grade: 4,
          gender: GenderType.female,
        ),
        const StudentProfile(
          firstName: 'Євген',
          lastName: 'Костюк',
          faculty: Faculty.technology,
          grade: 2,
          gender: GenderType.male,
        ),
        const StudentProfile(
          firstName: 'Наталія',
          lastName: 'Сидоренко',
          faculty: Faculty.law,
          grade: 5,
          gender: GenderType.female,
        ),
        const StudentProfile(
          firstName: 'Ростислав',
          lastName: 'Мороз',
          faculty: Faculty.healthSciences,
          grade: 3,
          gender: GenderType.male,
        ),
        const StudentProfile(
          firstName: 'Галина',
          lastName: 'Яценко',
          faculty: Faculty.economics,
          grade: 4,
          gender: GenderType.female,
        ),
        const StudentProfile(
          firstName: 'Ілля',
          lastName: 'Ткачук',
          faculty: Faculty.technology,
          grade: 5,
          gender: GenderType.male, 
        ),
      ];

      runApp(MaterialApp(
        title: 'Student Directory',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: StudentListScreen(students: studentProfiles),
      ));
    }

