import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class RainyCloudAnimation extends StatefulWidget {
  const RainyCloudAnimation({super.key});

  @override
  State<RainyCloudAnimation> createState() => _RainyCloudAnimationState();
}

class _RainyCloudAnimationState extends State<RainyCloudAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
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
          final movement = math.sin(_controller.value * 2 * math.pi) * 8;

          return Transform.translate(offset: Offset(movement, 0), child: child);
        },
        child: ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.40, 0.60, 0.80, 1.0],
              colors: [
                Colors.white,
                Colors.white,
                Color(0xCCFFFFFF),
                Color(0x66FFFFFF),
                Colors.transparent,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            'assets/images/rainy_cloud.png',
            width: screenWidth + 30,
            height: 430,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
