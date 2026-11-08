import 'package:flutter/material.dart';

class SunnyAnimation extends StatefulWidget {
  const SunnyAnimation({super.key});

  @override
  State<SunnyAnimation> createState() => _SunnyAnimationState();
}

class _SunnyAnimationState extends State<SunnyAnimation>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
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

        final glowSize = 230.0 + (_controller.value * 15);

        return SizedBox(
          width: 350,
          height: 350,

          child: Stack(
            alignment: Alignment.center,
            children: [

              // Atmospheric sunlight
              Container(
                width: glowSize + 100,
                height: glowSize + 100,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: RadialGradient(
                    colors: [
                      Colors.orange.withValues(alpha: 0.30),
                      Colors.orange.withValues(alpha: 0.12),
                      Colors.orange.withValues(alpha: 0.03),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Glowing sun
              Container(
                width: 110,
                height: 110,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: const RadialGradient(
                    center: Alignment(-0.3, -0.3),
                    colors: [
                      Color(0xFFFFE0A3),
                      Color(0xFFFFBB55),
                      Color(0xFFFF962E),
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(
                        alpha: 0.15 + (_controller.value * 0.12),
                      ),
                      blurRadius: 70,
                      spreadRadius: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}