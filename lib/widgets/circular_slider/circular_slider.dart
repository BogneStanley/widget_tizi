// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:widget_tizi/common/constants.dart';
import 'package:widget_tizi/common/helpers.dart';
import 'package:widget_tizi/widgets/circular_slider/circular_slider_controller.dart';
import 'package:lottie/lottie.dart';

class CircularSlider extends StatefulWidget {
  final CircularSliderController controller;
  const CircularSlider({super.key, required this.controller});

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  Offset currentDragOffset = Offset.zero;
  double startAngle = degToRad(90);
  double totalAngle = degToRad(360);

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Size canvasSize = Size(screenSize.width, screenSize.width - 35);
    Offset center = canvasSize.center(Offset.zero);
    final List dots = List.generate(
      30,
      (index) => generateSmallSlideDot(
        dotNumber: index,
        center: center,
        startAngle: startAngle,
        dotColor: Colors.white,
        dotSize: 5,
      ),
    );
    final List innerDots = List.generate(
      30,
      (i) {
        var index = i;
        if (0 <= index && index < 6) {
          return generateSmallSlideDot(
            dotNumber: index,
            center: center,
            startAngle: startAngle,
            dotSize: 15,
            dotColor: Color.fromARGB(0, 255, 143, 143),
            icon: const Icon(
              Icons.water_drop_outlined,
              color: Color.fromARGB(255, 255, 76, 76),
              size: 10,
            ),
            raduisSubstract: 25,
          );
        }
        if ((6 <= index && index < 11)) {
          return generateSmallSlideDot(
            dotNumber: index,
            center: center,
            startAngle: startAngle,
            dotSize: 15,
            dotColor: Color.fromARGB(0, 255, 143, 143),
            icon: const Icon(
              Icons.circle_outlined,
              color: Color.fromARGB(255, 211, 211, 211),
              size: 10,
            ),
            raduisSubstract: 25,
          );
        }
        if ((17 <= index && index < 22)) {
          return generateSmallSlideDot(
            dotNumber: index,
            center: center,
            startAngle: startAngle,
            dotSize: 15,
            dotColor: Color.fromARGB(0, 255, 143, 143),
            icon: const Icon(
              Icons.circle_outlined,
              color: Color.fromARGB(255, 211, 211, 211),
              size: 10,
            ),
            raduisSubstract: 25,
          );
        }
        if (11 <= index && index < 17) {
          return generateSmallSlideDot(
            dotNumber: index,
            center: center,
            startAngle: startAngle,
            dotSize: 15,
            dotColor: Color.fromARGB(0, 255, 143, 143),
            icon: const Icon(
              Icons.adjust,
              color: Color.fromARGB(255, 211, 211, 211),
              size: 10,
            ),
            raduisSubstract: 25,
          );
        }
        if (17 <= index && index < 28) {
          return generateSmallSlideDot(
            dotNumber: index,
            center: center,
            startAngle: startAngle,
            dotSize: 15,
            dotColor: Color.fromARGB(0, 255, 143, 143),
            icon: Transform.rotate(
              angle: 45 * math.pi / 180,
              child: const Icon(
                Icons.square_outlined,
                color: Color.fromARGB(255, 76, 124, 255),
                size: 10,
              ),
            ),
            raduisSubstract: 25,
          );
        }
        return Container();
      },
    );

    final List innerDotsLevel2 = List.generate(
      30,
      (i) {
        var index = i;
        if ((0 < index && index < 6) ||
            (12 < index && index < 17) ||
            (24 < index && index < 28) ||
            (21 == index) ||
            (19 == index)) {
          return generateSmallSlideDot(
            dotNumber: index,
            center: center,
            startAngle: startAngle,
            dotSize: 5,
            dotColor: Color.fromARGB(255, 213, 241, 226),
            raduisSubstract: 36,
          );
        }
        return SizedBox();
      },
    );

    Offset slideDotPos = toPolar(
        center -
            const Offset(
                Constants.defaultStrockWidth, Constants.defaultStrockWidth),
        widget.controller.currentAngle + startAngle,
        Constants.radius);
    return Stack(
      children: [
        CustomPaint(
          size: canvasSize,
          painter: CircleSliderPainter(
              startAngle: startAngle,
              currentAngle: widget.controller.currentAngle),
        ),
        ...dots,
        ...innerDots,
        ...innerDotsLevel2,
        Container(
          height: canvasSize.height,
          child: Center(
            child: LottieBuilder.asset(
              "assets/lotties/animation.json",
              height: 150,
              width: 150,
              reverse: true,
              frameRate: FrameRate.max,
            ),
          ),
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
              var angle = widget.controller.currentAngle +
                  toAngle(currentDragOffset, center) -
                  toAngle(previousOffset, center);
              widget.controller.changeAngle(normalizeAngle(angle));
            },
            child: DraggableSliderThumb(
              currentAngle: widget.controller.currentAngle,
            ),
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
          Color.fromARGB(255, 155, 182, 255),
          Color.fromARGB(255, 108, 189, 255),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = Constants.defaultStrockWidth
      ..strokeCap = StrokeCap.round;

    var slidePaint2 = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 255, 103, 103),
          Color.fromARGB(255, 255, 76, 76),
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
      toRadian(-120),
      toRadian(-65),
      false,
      slidePaint,
    );

    canvas.drawArc(
      rect,
      toRadian(-90),
      toRadian(55),
      false,
      slidePaint2,
    );

    canvas.drawArc(
      rect,
      toRadian(30),
      toRadian(80),
      false,
      slidePaint2
        ..shader = const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 184, 103),
            Color.fromARGB(255, 255, 171, 76),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = Constants.defaultStrockWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DraggableSliderThumb extends StatelessWidget {
  final double currentAngle;
  const DraggableSliderThumb({super.key, required this.currentAngle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 233, 233, 233),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: intToColor(degToDays(radToDeg((currentAngle)))),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
              "${degToDays(radToDeg((currentAngle))) + 1}\nDay",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 7,
              ),
            ))),
      ),
    );
  }
}

Widget generateSmallSlideDot({
  required int dotNumber,
  required Offset center,
  required double startAngle,
  required Color dotColor,
  double? dotSize,
  double raduisSubstract = 0,
  Widget? icon,
}) {
  Offset slideDotPos = toPolar(
      center -
          const Offset(
              Constants.defaultStrockWidth, Constants.defaultStrockWidth),
      degToRad((dotNumber * 12) + 4 + 180) + startAngle,
      Constants.radius - raduisSubstract);
  return Positioned(
    top: slideDotPos.dy,
    left: slideDotPos.dx,
    child: SmallSlideDot(
      dotColor: dotColor,
      icon: icon,
      size: dotSize ?? 8,
    ),
  );
}

class SmallSlideDot extends StatelessWidget {
  final Color dotColor;
  final Widget? icon;
  final double size;
  const SmallSlideDot({
    super.key,
    required this.dotColor,
    this.icon,
    this.size = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 233, 233, 233),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: icon ?? null,
          ),
        ),
      ),
    );
  }
}
