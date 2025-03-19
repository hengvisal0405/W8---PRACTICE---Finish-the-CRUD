import 'dart:async';
import '../models/course.dart';
import 'course_repo.dart';

class CoursesMockRepository extends CoursesRepository {
  @override
  List<Course> getCourses() {
    return [
    Course(name: "Flutter Basics"),
    Course(name: "How to master at flutter without Coding"),
    Course(name: "Flutter not the best"),
    ];
  }
  @override
  void addScore(Course course, CourseScore score) {
    course.addScore(score);
  }
}