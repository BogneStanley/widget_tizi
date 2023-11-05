// degre to radian
import 'dart:math' as math;
import 'package:flutter/material.dart';

const fullAngleInRadians = math.pi * 2;

double degToRad(double deg) => deg * (math.pi / 180.0);

double radToDeg(double rad) => rad * (180.0 / math.pi);

int degToDays(double deg) => ((deg + 180) % 360) ~/ 12;

int daysToDeg(int day) => (day * 12);

double normalizeAngle(double angle) => normalize(angle, fullAngleInRadians);

Offset toPolar(Offset center, double radians, double radius) =>
    center + Offset.fromDirection(radians, radius);

double normalize(double value, double max) => (value % max + max) % max;

double toAngle(Offset position, Offset center) => (position - center).direction;

double toRadian(double value) => (value * math.pi) / 180;

Color intToColor(int deg) {
  if (deg >= 0 && deg < 5) {
    return Color.lerp(
      const Color.fromARGB(255, 255, 103, 103),
      const Color.fromARGB(255, 255, 76, 76),
      deg / 360,
    )!;
  }
  if (deg >= 10 && deg < 17) {
    return Color.lerp(
      const Color.fromARGB(255, 255, 184, 103),
      const Color.fromARGB(255, 255, 171, 76),
      deg / 360,
    )!;
  }
  if (deg >= 22 && deg < 28) {
    return Color.lerp(
      const Color.fromARGB(255, 155, 182, 255),
      const Color.fromARGB(255, 108, 189, 255),
      deg / 360,
    )!;
  }
  return Color.lerp(
    const Color.fromARGB(255, 223, 223, 223),
    const Color.fromARGB(255, 223, 223, 223),
    deg / 360,
  )!;
}
