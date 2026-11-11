import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class LightningAnimation extends StatefulWidget {
  const LightningAnimation({super.key});

  @override
  State<LightningAnimation> createState() => _LightningAnimationState();
}

class _LightningAnimationState extends State<LightningAnimation> {
  final math.Random _random = math.Random();

  Timer? _timer;

  bool _isFlashing = false;

  double _lightningX = 0.5;
  double _lightningY = 0.0;
  int _seed = 0;

  @override
  void initState() {
    super.initState();
    _scheduleLightning();
  }

  void _scheduleLightning() {
    final delay = 3 + _random.nextInt(6);

    _timer = Timer(Duration(seconds: delay), () {
      _flashLightning();
    });
  }

  Future<void> _flashLightning() async {
    if (!mounted) return;

    // Generate a new position and shape for every strike.
    setState(() {
      _lightningX = 0.15 + _random.nextDouble() * 0.7;
      _lightningY = 0.32 + _random.nextDouble() * 0.12;
      _seed = _random.nextInt(100000);
      _isFlashing = true;
    });

    // First flash
    await Future.delayed(Duration(milliseconds: 70 + _random.nextInt(50)));

    if (!mounted) return;
    setState(() => _isFlashing = false);

    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;

    // Second flash at the same position
    setState(() => _isFlashing = true);

    await Future.delayed(Duration(milliseconds: 50 + _random.nextInt(50)));

    if (!mounted) return;
    setState(() => _isFlashing = false);

    _scheduleLightning();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _isFlashing ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 40),
        child: CustomPaint(
          size: Size.infinite,
          painter: LightningPainter(
            lightningX: _lightningX,
            lightningY: _lightningY,
            seed: _seed,
          ),
        ),
      ),
    );
  }
}

class LightningPainter extends CustomPainter {
  final double lightningX;
  final double lightningY;
  final int seed;

  LightningPainter({
    required this.lightningX,
    required this.lightningY,
    required this.seed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed);
    final path = Path();

    double x = size.width * lightningX;
    double y = size.height * lightningY;

    path.moveTo(x, y);

    final startX = x;

    // Main lightning bolt
    for (int i = 0; i < 9; i++) {
      x += (random.nextDouble() - 0.5) * size.width * 0.12;
      y += size.height * (0.035 + random.nextDouble() * 0.01);

      path.lineTo(x, y);

      // Random branches
      if (i == 2 || i == 4 || i == 6) {
        final branchX = x + (random.nextDouble() - 0.5) * size.width * 0.22;

        final branchY = y + size.height * 0.06;

        path.moveTo(x, y);
        path.lineTo(branchX, branchY);
        path.moveTo(x, y);
      }
    }

    // Glow effect
    final glowPaint = Paint()
      ..color = const Color(0xFFB8D8FF).withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawPath(path, glowPaint);

    // Bright lightning
    final lightningPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, lightningPaint);
  }

  @override
  bool shouldRepaint(covariant LightningPainter oldDelegate) {
    return oldDelegate.seed != seed ||
        oldDelegate.lightningX != lightningX ||
        oldDelegate.lightningY != lightningY;
  }
}
