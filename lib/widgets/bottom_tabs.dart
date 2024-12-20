import 'package:flutter/material.dart';
import '../screens/faculty_list_screen.dart';
import '../screens/student_list_screen.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({super.key});

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  final List<Widget> _screens = [
    const FacultyListScreen(),
    const StudentListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Faculties'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Students'),
        ],
      ),
    );
  }
}
