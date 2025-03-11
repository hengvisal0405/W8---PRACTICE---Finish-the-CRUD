import 'package:flutter/material.dart';
//Create Model for color counter
//Create a class named ColorCounter that extends ChangeNotifier.
class ColorCounter extends ChangeNotifier {
  int redTapCount = 0;
  int blueTapCount = 0;

  void incrementRedTapCount() {
    redTapCount++;
    print('Red tap count incremented to $redTapCount');
    notifyListeners();
  }

  void incrementBlueTapCount() {
    blueTapCount++;
    print('Blue tap count incremented to $blueTapCount');
    notifyListeners();
    //Handle for listern to the state change
  }
}
//-Centralized in ColorCounter class It manage all the state in a single class
