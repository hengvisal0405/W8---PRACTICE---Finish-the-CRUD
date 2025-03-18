import 'package:flutter/material.dart';
import 'package:my_app/START_CODE/EX_1_START_CODE/screens/course_list_screen.dart';
import 'package:provider/provider.dart';

import 'providers/course_provider.dart';
import 'repositories/course_mock_repo.dart';
import 'repositories/course_repo.dart';

void main() {
  CoursesRepository repository = CoursesMockRepository();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return CoursesProvider(coursesRepository: repository);
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CoursesListScreen(),
      ),
    ),
  );
}
