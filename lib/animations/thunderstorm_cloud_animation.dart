import 'dart:math' as math;

import 'package:flutter/material.dart';

class ThunderstormCloudAnimation extends StatefulWidget {
  const ThunderstormCloudAnimation({super.key});

  @override
  State<ThunderstormCloudAnimation> createState() =>
      _ThunderstormCloudAnimationState();
}

class _ThunderstormCloudAnimationState extends State<ThunderstormCloudAnimation>
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
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: 430,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final movement = math.sin(_controller.value * 2 * math.pi) * 10;

          return Transform.translate(offset: Offset(movement, 0), child: child);
        },
        child: ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.45, 0.70, 1.0],
              colors: [
                Colors.white,
                Colors.white,
                Color(0x99FFFFFF),
                Colors.transparent,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            'assets/images/thunderstorm_clouds.png',
            width: screenWidth + 30,
            height: 430,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
