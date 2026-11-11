import 'dart:math' as math;

import 'package:flutter/material.dart';

class SnowAnimation extends StatefulWidget {
  const SnowAnimation({super.key});

  @override
  State<SnowAnimation> createState() => _SnowAnimationState();
}

class _SnowAnimationState extends State<SnowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
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
          painter: SnowPainter(progress: _controller.value),
        );
      },
    );
  }
}

class SnowPainter extends CustomPainter {
  final double progress;

  SnowPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Three layers: background, middle and foreground
    final layers = [
      {
        'count': 45,
        'speed': 0.35,
        'minRadius': 0.5,
        'maxRadius': 1.2,
        'opacity': 0.35,
        'drift': 5.0,
        'blur': 1.0,
      },
      {
        'count': 35,
        'speed': 0.65,
        'minRadius': 1.2,
        'maxRadius': 2.2,
        'opacity': 0.60,
        'drift': 10.0,
        'blur': 0.0,
      },
      {
        'count': 20,
        'speed': 1.0,
        'minRadius': 2.2,
        'maxRadius': 3.5,
        'opacity': 0.90,
        'drift': 18.0,
        'blur': 0.0,
      },
    ];

    for (int layerIndex = 0; layerIndex < layers.length; layerIndex++) {
      final layer = layers[layerIndex];

      final count = layer['count']! as int;
      final speed = layer['speed']! as double;
      final minRadius = layer['minRadius']! as double;
      final maxRadius = layer['maxRadius']! as double;
      final opacity = layer['opacity']! as double;
      final drift = layer['drift']! as double;
      final blur = layer['blur']! as double;

      for (int i = 0; i < count; i++) {
        final random = math.Random(i + layerIndex * 1000);

        final initialX = random.nextDouble() * size.width;
        final initialY = random.nextDouble() * size.height;

        final phase = random.nextDouble() * 2 * math.pi;

        final x =
            (initialX + math.sin(progress * 2 * math.pi + phase) * drift) %
            size.width;

        final y = (initialY + progress * size.height * speed) % size.height;

        final radius =
            minRadius + random.nextDouble() * (maxRadius - minRadius);

        final paint = Paint()..color = Colors.white.withValues(alpha: opacity);

        if (blur > 0) {
          paint.maskFilter = MaskFilter.blur(BlurStyle.normal, blur);
        }

        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SnowPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
