import 'dart:math' as math;

import 'package:flutter/material.dart';

class CloudAnimation extends StatefulWidget {
  const CloudAnimation({super.key});

  @override
  State<CloudAnimation> createState() => _CloudAnimationState();
}

class _CloudAnimationState extends State<CloudAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
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
        final movement = math.sin(_controller.value * 2 * math.pi) * 12;

        return Transform.translate(
          offset: Offset(movement, 0),

          child: Image.asset(
            'assets/images/clouds.png',
            width: MediaQuery.of(context).size.width * 1.15,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
