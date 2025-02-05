import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller; // Controls the animation
  late Animation<double> animation; // Defines the animation progress

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 1 second
    controller = AnimationController(
      vsync: this, // Prevents unnecessary resource usage
      duration: const Duration(seconds: 1),
    );

    // Defines the animation range from 0 to 1
    animation = Tween<double>(begin: 0, end: 1).animate(controller);

    // Adds a listener to repeat the animation by reversing direction
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(); // Moves the ball back down
      } else if (status == AnimationStatus.dismissed) {
        controller.forward(); // Moves the ball up again
      }
    });

    controller.forward(); // Starts the animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Positions the ball at the bottom
          children: [
            AnimatedBuilder(
              animation: animation, // Rebuilds when the animation updates
              builder: (context, child) => CustomPaint(
                size: const Size(200, 200),
                painter: BouncingBallPainter(animation.value), // Updates ball position
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Frees up resources when widget is removed
    super.dispose();
  }
}

// CustomPainter to draw the bouncing ball
class BouncingBallPainter extends CustomPainter {
  final double animationValue; // Controls the ball's vertical position

  BouncingBallPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Draws the ball, moving up and down based on animationValue
    canvas.drawCircle(
      Offset(size.width / 2, size.height - (size.height * animationValue)),
      20, // Ball radius
      Paint()..color = Colors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redraws the ball in every animation frame
  }
}
