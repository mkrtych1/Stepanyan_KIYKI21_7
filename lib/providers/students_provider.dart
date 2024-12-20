import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student_profile.dart';

class StudentsNotifier extends StateNotifier<List<StudentProfile>> {
  StudentsNotifier() : super([]);

  StudentProfile? _lastDeletedStudent;
  int? _lastDeletedIndex;

  void addEntry(StudentProfile student) {
    state = [...state, student];
  }

  void updateEntry(int index, StudentProfile updatedStudent) {
    final updatedList = [...state];
    updatedList[index] = updatedStudent;
    state = updatedList;
  }

  void removeEntry(int index) {
    _lastDeletedStudent = state[index];
    _lastDeletedIndex = index;
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
  }

  void restoreEntry() {
    if (_lastDeletedStudent != null && _lastDeletedIndex != null) {
      state = [
        ...state.sublist(0, _lastDeletedIndex!),
        _lastDeletedStudent!,
        ...state.sublist(_lastDeletedIndex!),
      ];
    }
  }
}

final provider =
    StateNotifierProvider<StudentsNotifier, List<StudentProfile>>(
  (ref) => StudentsNotifier(),
);
