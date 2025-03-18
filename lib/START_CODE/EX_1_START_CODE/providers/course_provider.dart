import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repo.dart';

class CoursesProvider extends ChangeNotifier {
  List<Course> _courses = [];
  final CoursesRepository coursesRepository;
  CoursesProvider({required this.coursesRepository}) {
    fetchCourses();
  }

  List<Course> get courses => _courses;
  void fetchCourses() {
    _courses = coursesRepository.getCourses();
    notifyListeners();
  }

  Course? getCourse(String courseId) {
    return _courses.firstWhere((c) => c.name == courseId);
  }

  void addScore(String courseId, CourseScore score) {
    Course? course = getCourse(courseId);
    if (course != null) {
      coursesRepository.addScore(course, score);
      notifyListeners();
    }
  }
}


// class CoursesProvider extends ChangeNotifier {
//   final _repository _repository;

//   CoursesProvider(this._repository);

  // List<Course> _courses = [];
  // Course? _selectedCourse;
  // bool _isLoading = false;
  // String? _error;

  // List<Course> get courses => _courses;
  // Course? get selectedCourse => _selectedCourse;
  // bool get isLoading => _isLoading;
  // String? get error => _error;

//   Future<List<Course>> getCourses() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       _courses = await _repository.getCourses();
//       _isLoading = false;
//       notifyListeners();
//       return _courses;
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//       return [];
//     }
//   }
//   Future<Course?> getCourseFor(String courseName) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _selectedCourse = await _repository.getCourseFor(courseName);
//       _isLoading = false;
//       notifyListeners();
//       return _selectedCourse;
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//       return null;
//     }
//   }
//   Future<void> addScore(String courseId, CourseScore score) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       await _repository.addScore(courseId, score);
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//     }
//   }
// }

