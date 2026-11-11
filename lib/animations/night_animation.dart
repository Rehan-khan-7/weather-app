import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class NightAnimation extends StatefulWidget {
  const NightAnimation({super.key});

  @override
  State<NightAnimation> createState() => _NightAnimationState();
}

class _NightAnimationState extends State<NightAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _shootingController;

  final math.Random _random = math.Random();

  Timer? _shootingTimer;

  bool _showShootingStar = false;

  double _shootingX = 0.2;
  double _shootingY = 0.1;

  @override
  void initState() {
    super.initState();

    // Star twinkling
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Shooting star movement
    _shootingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _shootingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showShootingStar = false;
        });

        _scheduleShootingStar();
      }
    });

    _scheduleShootingStar();
  }

  void _scheduleShootingStar() {
    final delay = 5 + _random.nextInt(8);

    _shootingTimer = Timer(Duration(seconds: delay), () {
      if (!mounted) return;

      setState(() {
        _shootingX = 0.15 + _random.nextDouble() * 0.55;
        _shootingY = 0.05 + _random.nextDouble() * 0.25;
        _showShootingStar = true;
      });

      _shootingController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _shootingTimer?.cancel();
    _controller.dispose();
    _shootingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _shootingController]),
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: NightPainter(
            progress: _controller.value,
            shootingProgress: _shootingController.value,
            showShootingStar: _showShootingStar,
            shootingX: _shootingX,
            shootingY: _shootingY,
          ),
        );
      },
    );
  }
}

class NightPainter extends CustomPainter {
  final double progress;
  final double shootingProgress;
  final bool showShootingStar;
  final double shootingX;
  final double shootingY;

  NightPainter({
    required this.progress,
    required this.shootingProgress,
    required this.showShootingStar,
    required this.shootingX,
    required this.shootingY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Moon position
    final moonCenter = Offset(size.width * 0.82, size.height * 0.07);

    // Moon glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0x55FFF1C1),
          const Color(0x22FFF1C1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: moonCenter, radius: 65));

    canvas.drawCircle(moonCenter, 65, glowPaint);

    // Moon
    final moonPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFFBEA), Color(0xFFE8DDBD)],
      ).createShader(Rect.fromCircle(center: moonCenter, radius: 22));

    canvas.drawCircle(moonCenter, 22, moonPaint);

    // Stars
    for (int i = 0; i < 90; i++) {
      final random = math.Random(i);

      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      final radius = 0.5 + random.nextDouble() * 1.5;

      final phase = random.nextDouble() * 2 * math.pi;

      final twinkle = (math.sin(progress * 2 * math.pi + phase) + 1) / 2;

      final opacity = 0.25 + twinkle * 0.65;

      final starPaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity);

      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }

    // Shooting star
    if (showShootingStar) {
      _drawShootingStar(canvas, size);
    }
  }

  void _drawShootingStar(Canvas canvas, Size size) {
    final start = Offset(size.width * shootingX, size.height * shootingY);

    final end = Offset(
      start.dx + size.width * 0.28 * shootingProgress,
      start.dy + size.height * 0.20 * shootingProgress,
    );

    final trailStart = Offset(
      end.dx - size.width * 0.10,
      end.dy - size.height * 0.07,
    );

    final trailPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.transparent, const Color(0x99B8D8FF), Colors.white],
      ).createShader(Rect.fromPoints(trailStart, end))
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(trailStart, end, trailPaint);

    // Glow
    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawCircle(end, 4, glowPaint);

    // Bright head
    final headPaint = Paint()..color = Colors.white;

    canvas.drawCircle(end, 1.8, headPaint);
  }

  @override
  bool shouldRepaint(covariant NightPainter oldDelegate) {
    return true;
  }
}
