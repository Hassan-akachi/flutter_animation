import 'package:flutter/material.dart';

class PulsatingHeartAnimation extends StatefulWidget {
  const PulsatingHeartAnimation({super.key});

  @override
  State<PulsatingHeartAnimation> createState() => _PulsatingHeartAnimationState();
}

class _PulsatingHeartAnimationState extends State<PulsatingHeartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Create a Tween for the size of the heart
    _animation = Tween<double>(begin: 50, end: 200).animate(_controller)
      ..addListener(() {
        setState(() {}); // Update the UI on every animation tick
      });

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulsating Heart Animation'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(_animation.value, _animation.value),
          painter: HeartPainter(
            color: Colors.red,
            shadowColor1: Colors.pink.withOpacity(0.5),
            shadowColor2: Colors.red.withOpacity(0.5),
            blurRadius: _animation.value,
            spreadRadius: _animation.value / 2,
          ),
        ),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  final Color color;
  final Color shadowColor1;
  final Color shadowColor2;
  final double blurRadius;
  final double spreadRadius;

  HeartPainter({
    required this.color,
    required this.shadowColor1,
    required this.shadowColor2,
    required this.blurRadius,
    required this.spreadRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    // Create path for heart shape
    Path path = Path();
    path.moveTo(width / 2, height / 5);

    // Left curve
    path.cubicTo(
      width / 8, 0,
      -width / 4, height / 2,
      width / 2, height,
    );

    // Right curve
    path.cubicTo(
      width * 1.25, height / 2,
      width * 0.875, 0,
      width / 2, height / 5,
    );

    // Add shadows
    canvas.drawPath(
      path,
      Paint()
        ..color = shadowColor1
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius / 10),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = shadowColor2
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius / 10),
    );

    // Draw the heart
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}