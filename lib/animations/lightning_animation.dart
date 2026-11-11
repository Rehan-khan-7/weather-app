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
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Full sky illumination
          AnimatedOpacity(
            opacity: _isFlashing ? 0.16 : 0.0,
            duration: const Duration(milliseconds: 45),
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [
                    Color(0xFFB8D8FF),
                    Color(0xFF647FA8),
                    Color(0x00000000),
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // Lightning bolt
          AnimatedOpacity(
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
        ],
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

    final mainPath = Path();
    final branchPath = Path();

    double x = size.width * lightningX;
    double y = size.height * lightningY;

    mainPath.moveTo(x, y);

    final points = <Offset>[Offset(x, y)];

    // Main lightning bolt
    for (int i = 0; i < 11; i++) {
      x += (random.nextDouble() - 0.5) * size.width * 0.09;
      y += size.height * (0.035 + random.nextDouble() * 0.025);

      x = x.clamp(size.width * 0.05, size.width * 0.95);

      final point = Offset(x, y);

      points.add(point);
      mainPath.lineTo(x, y);
    }

    // Natural branching
    for (int i = 2; i < points.length - 1; i += 2) {
      final start = points[i];

      final direction = random.nextBool() ? 1.0 : -1.0;

      double branchX = start.dx;
      double branchY = start.dy;

      branchPath.moveTo(branchX, branchY);

      final branchLength = 2 + random.nextInt(3);

      for (int j = 0; j < branchLength; j++) {
        branchX +=
            direction * size.width * (0.015 + random.nextDouble() * 0.025);

        branchY += size.height * 0.025;

        branchPath.lineTo(branchX, branchY);
      }
    }

    // Combined glow
    final glowPaint = Paint()
      ..color = const Color(0xFFB8D8FF).withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);

    canvas.drawPath(mainPath, glowPaint);
    canvas.drawPath(branchPath, glowPaint);

    // Main bright bolt
    final mainPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(mainPath, mainPaint);

    // Smaller branches
    final branchPaint = Paint()
      ..color = const Color(0xFFEAF4FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(branchPath, branchPaint);
  }

  @override
  bool shouldRepaint(covariant LightningPainter oldDelegate) {
    return oldDelegate.seed != seed ||
        oldDelegate.lightningX != lightningX ||
        oldDelegate.lightningY != lightningY;
  }
}
