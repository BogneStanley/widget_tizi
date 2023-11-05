// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../common/helpers.dart';

class CircularSliderController extends ChangeNotifier {
  double currentAngle = 0;
  int day = 0;
  CircularSliderController({
    required this.day,
  }) {
    currentAngle = degToRad(day * 12);
  }

  changeDay(int day) {
    this.day = day - 1;
    currentAngle = degToRad(((day - 1) * 12) + 184);
    notifyListeners();
  }

  changeAngle(double angle) {
    currentAngle = angle;
    notifyListeners();
  }
}
