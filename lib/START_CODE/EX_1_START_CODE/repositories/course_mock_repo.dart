import 'dart:async';
import '../models/course.dart';
import 'course_repo.dart';
// class CoursesMockRepository implements CoursesRepository {
//   final List<Course> _courses = [
//     Course(name: "Flutter Basics"),
//     Course(name: "How to master at flutter without Coding"),
//     Course(name: "Flutter not the best"),
//   ];

//   @override
//   Future<List<Course>> getCourses() async {
//     await Future.delayed(const Duration(milliseconds: 800));
//     return _courses;
//   }
//   @override
//   Future<Course?> getCourseFor(String courseName) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     try {
//       return _courses.firstWhere((course) => course.name == courseName);
//     } catch (e) {
//       throw Exception('Course not found');
//     }
//   }

//   @override
//   Future<void> addScore(String courseName, CourseScore score) async {
//     // Simulate network delay
//     await Future.delayed(const Duration(milliseconds: 300));

//     try {
//       final course = await getCourseFor(courseName);
//       course?.addScore(score);
//     } catch (e) {
//       throw Exception('Failed to add score: ${e.toString()}');
//     }
//   }
// }
class CoursesMockRepository extends CoursesRepository {
  @override
  List<Course> getCourses() {
    return [
      Course(name: 'HTML'),
      Course(name: 'java'),
      Course(name: 'hh'),
      Course(name: 'FLUTTER'),
      Course(name: 'hfg'),
    ];
  }

  @override
  void addScore(Course course, CourseScore score) {
    course.addScore(score);
  }
}