import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student_profile.dart';

class StudentsState {
  final List<StudentProfile> studentList;
  final bool loading;
  final String? msg;

  StudentsState({
    required this.studentList,
    required this.loading,
    this.msg,
  });

  StudentsState copyWith({
    List<StudentProfile>? students,
    bool? isLoading,
    String? errorMessage,
  }) {
    return StudentsState(
      studentList: students ?? this.studentList,
      loading: isLoading ?? this.loading,
      msg: errorMessage ?? this.msg,
    );
  }
}

class StudentsNotifier extends StateNotifier<StudentsState> {
  StudentsNotifier() : super(StudentsState(studentList: [], loading: false));

  StudentProfile? _removedStudent;
  int? _removedIndex;

  Future<void> loadStudents() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final students = await StudentProfile.remoteGetList();
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load students: $e',
      );
    }
  }

  Future<void> addEntry(
    String firstName,
    String lastName,
    faculty,
    gender,
    int grade,
  ) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final student = await StudentProfile.remoteCreate(
          firstName, lastName, faculty, gender, grade);
      state = state.copyWith(
        students: [...state.studentList, student],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to add student: $e',
      );
    }
  }

  Future<void> editEntry(
    int index,
    String firstName,
    String lastName,
    faculty,
    gender,
    int grade,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final updatedStudent = await StudentProfile.remoteUpdate(
        state.studentList[index].id,
        firstName,
        lastName,
        faculty,
        gender,
        grade,
      );
      final updatedList = [...state.studentList];
      updatedList[index] = updatedStudent;
      state = state.copyWith(students: updatedList, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to edit student: $e',
      );
    }
  }

  void removeEntry(int index) {
    _removedStudent = state.studentList[index];
    _removedIndex = index;
    final updatedList = [...state.studentList];
    updatedList.removeAt(index);
    state = state.copyWith(students: updatedList);
  }

  void restoreEntry() {
    if (_removedStudent != null && _removedIndex != null) {
      final updatedList = [...state.studentList];
      updatedList.insert(_removedIndex!, _removedStudent!);
      state = state.copyWith(students: updatedList);
    }
  }

  Future<void> removeEntryDb() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      if (_removedStudent != null) {
        await StudentProfile.remoteDelete(_removedStudent!.id);
        _removedStudent = null;
        _removedIndex = null;
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to delete student: $e',
      );
    }
  }
}

final provider =
    StateNotifierProvider<StudentsNotifier, StudentsState>((ref) {
  final notifier = StudentsNotifier();
  notifier.loadStudents();
  return notifier;
});
