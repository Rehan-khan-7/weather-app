import 'dart:math' as math;

import 'package:flutter/material.dart';

class RainyAnimation extends StatefulWidget {
  const RainyAnimation({super.key});

  @override
  State<RainyAnimation> createState() => _RainyAnimationState();
}

class _RainyAnimationState extends State<RainyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: RainPainter(progress: _controller.value),
        );
      },
    );
  }
}

class RainPainter extends CustomPainter {
  final double progress;

  RainPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withValues(alpha: 0.45)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const int rainCount = 100;

    for (int i = 0; i < rainCount; i++) {
      final random = math.Random(i);

      final initialX = random.nextDouble() * size.width;
      final initialY = random.nextDouble() * size.height;

      final speed = 0.5 + random.nextDouble() * 0.8;

      // Wind effect: rain moves towards the left
      final x = (initialX - progress * size.width * 0.25 * speed) % size.width;

      final y = (initialY + progress * size.height * speed) % size.height;

      final length = 10 + random.nextDouble() * 12;

      canvas.drawLine(Offset(x, y), Offset(x - length*0.4, y + length), paint);
    }
  }

  @override
  bool shouldRepaint(covariant RainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
