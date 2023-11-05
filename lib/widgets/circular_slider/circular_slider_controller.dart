// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../common/helpers.dart';

class CircularSliderController extends ChangeNotifier {
  double currentAngle = 0;
  CircularSliderController({
    required this.currentAngle,
  });

  changeAngle(double angle) {
    currentAngle = angle;
    notifyListeners();
  }
}
