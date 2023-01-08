// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestProgressCircle extends StatefulWidget {
  const TestProgressCircle({super.key});

  @override
  State<TestProgressCircle> createState() => _TestProgressCircleState();
}

class _TestProgressCircleState extends State<TestProgressCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      // child: ,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.image,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ProgressCircle(
                    progress: _controller.value * 100,
                    outlineThikness: 10,
                    size: 100,
                    hasEnd: _controller.value == 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    super.key,
    required this.progress,
    this.outlineThikness = 10,
    this.foregroundColor = Colors.green,
    this.backgroundColor = const Color(0xFFF2F2F2),
    this.size = 200,
    required this.hasEnd,
  });
  final double progress;
  final double size;
  final double outlineThikness;
  final Color foregroundColor;
  final Color backgroundColor;
  final bool hasEnd;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _ProgressCirclePainter(
              progress: progress,
              outlineThikness: outlineThikness,
              color: foregroundColor,
              backgroundColor: backgroundColor,
            ),
          ),
          hasEnd
              ? _Glowing(
                  color: foregroundColor,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _Glowing extends StatefulWidget {
  const _Glowing({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  State<_Glowing> createState() => _GlowingState();
}

class _GlowingState extends State<_Glowing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curve;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _opacity = Tween<double>(begin: 1, end: 0).animate(_curve);
    _scale = Tween<double>(begin: 1, end: 1.4).animate(_curve);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      child: _content(),
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: child,
          ),
        );
      },
    );
  }

  Container _content() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 10,
          color: Colors.green.withOpacity(0.5),
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ProgressCirclePainter extends CustomPainter {
  final double progress;
  final double outlineThikness;
  final Paint painter;
  final Paint backgroundPainter;
  _ProgressCirclePainter({
    required Color color,
    required Color backgroundColor,
    required this.progress,
    this.outlineThikness = 5,
  })  : painter = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = outlineThikness
          ..strokeCap = StrokeCap.round,
        backgroundPainter = Paint()..color = backgroundColor;
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = math.min(size.width, size.height) / 2;

    final outlinePath = _background(center, radius);
    canvas.drawPath(outlinePath, backgroundPainter);

    const startAngle = -math.pi / 2;
    final sweepAngle = (math.pi * 2) * (progress / 100);
    const useCenter = false;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (outlineThikness / 2)),
      startAngle,
      sweepAngle,
      useCenter,
      painter,
    );
  }

  Path _background(Offset center, double radius) {
    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..addOval(
          Rect.fromCircle(center: center, radius: radius - outlineThikness))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
