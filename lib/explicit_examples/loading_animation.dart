import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  final double progress; // The target progress (0.0 to 1.0)
  final Color color; // The color of the progress indicator

  const RadialProgressAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<RadialProgressAnimation> createState() =>
      _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> loadAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a 1-second duration
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // Create a tween animation from 0 to the given progress value
    loadAnimation = Tween<double>(begin: 0, end: widget.progress)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Start the animation automatically when the widget is initialized
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: loadAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Circular progress indicator with animated progress value
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: loadAnimation.value, // Animated progress
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade200,
                    color: widget.color,
                  ),
                ),
                // Display the percentage value in the center
                Text(
                  '${(loadAnimation.value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Restart the animation when the button is pressed
          controller.reset();
          controller.forward();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }
}
