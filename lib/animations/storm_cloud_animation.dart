import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class StormCloudAnimation extends StatefulWidget {
  const StormCloudAnimation({super.key});

  @override
  State<StormCloudAnimation> createState() => _StormCloudAnimationState();
}

class _StormCloudAnimationState extends State<StormCloudAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
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
      height: 230,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final movement = math.sin(_controller.value * 2 * math.pi) * 12;

          return Transform.translate(offset: Offset(movement, 0), child: child);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Layer 1: Original sharp image
            Image.asset('assets/images/storm_clouds.png', fit: BoxFit.fill),

            // Layer 2: Blurred image with gradient transition
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  stops: [0.0, 0.45, 0.65, 0.85, 1.0],

                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0x40FFFFFF),
                    Color(0xBFFFFFFF),
                    Colors.white,
                  ],
                ).createShader(bounds);
              },

              blendMode: BlendMode.dstIn,

              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 10),

                child: Image.asset(
                  'assets/images/storm_clouds.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
