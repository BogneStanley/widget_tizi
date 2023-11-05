// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:widget_tizi/common/constants.dart';
import 'package:widget_tizi/common/helpers.dart';

class CircularSlider2 extends StatefulWidget {
  const CircularSlider2({super.key});

  @override
  State<CircularSlider2> createState() => _CircularSlider2State();
}

class _CircularSlider2State extends State<CircularSlider2> {
  Offset currentDragOffset = Offset.zero;
  double currentAngle = 0;
  double startAngle = degToRad(90);
  double totalAngle = degToRad(360);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Size canvasSize = Size(screenSize.width, screenSize.width - 35);
    Offset center = canvasSize.center(Offset.zero);
    Offset slideDotPos = toPolar(
        center -
            Offset(Constants.defaultStrockWidth, Constants.defaultStrockWidth),
        currentAngle + startAngle,
        Constants.radius);
    return Stack(
      children: [
        CustomPaint(
          size: canvasSize,
          painter: CircleSliderPainter(
              startAngle: startAngle, currentAngle: currentAngle),
        ),
        Positioned(
          top: slideDotPos.dy,
          left: slideDotPos.dx,
          child: GestureDetector(
            onPanStart: (details) {
              RenderBox getBox = context.findRenderObject() as RenderBox;
              currentDragOffset = getBox.globalToLocal(details.globalPosition);
            },
            onPanUpdate: (details) {
              var previousOffset = currentDragOffset;
              currentDragOffset += details.delta;
              var angle = currentAngle +
                  toAngle(currentDragOffset, center) -
                  toAngle(previousOffset, center);
              currentAngle = normalizeAngle(angle);
              setState(() {});
            },
            child: const SlideDot(),
          ),
        ),
      ],
    );
  }
}

// CircleSliderPainter class
class CircleSliderPainter extends CustomPainter {
  final double startAngle;
  final double currentAngle;
  CircleSliderPainter({
    required this.startAngle,
    required this.currentAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset.zero);

    Rect rect = Rect.fromCircle(center: center, radius: Constants.radius);
    var slidePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.blue,
          Color.fromARGB(255, 108, 189, 255),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = Constants.defaultStrockWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      Paint()
        ..color = const Color.fromARGB(255, 231, 231, 231)
        ..style = PaintingStyle.stroke
        ..strokeWidth = Constants.defaultStrockWidth,
    );
    canvas.drawArc(
      rect,
      startAngle,
      currentAngle,
      false,
      slidePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SlideDot extends StatelessWidget {
  const SlideDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
            height: 15,
            width: 15,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: BoxShape.circle,
            )),
      ),
    );
  }
}
