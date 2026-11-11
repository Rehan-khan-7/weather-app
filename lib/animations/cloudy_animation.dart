import 'dart:math' as math;
import 'package:flutter/material.dart';

class CloudyAnimation extends StatefulWidget {
  const CloudyAnimation({super.key});

  @override
  State<CloudyAnimation> createState() => _CloudyAnimationState();
}

class _CloudyAnimationState extends State<CloudyAnimation>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
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
      height: 300,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final movement =
              math.sin(_controller.value * 2 * math.pi) * 8;

          return Transform.translate(
            offset: Offset(movement, 0),
            child: child,
          );
        },
        child: ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.30, 0.65, 0.85, 1.0],
              colors: [
                Colors.white,
                Colors.white,
                Color(0xCCFFFFFF),
                Color(0x80FFFFFF),
                Colors.transparent,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            'assets/images/cloudy_sky.png',
            width: screenWidth +30,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}