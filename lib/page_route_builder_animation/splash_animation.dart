import 'dart:async';
import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a duration of 5 seconds
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    // Define a scale animation that increases the size of the widget from 1x to 10x
    scaleAnimation = Tween<double>(begin: 1, end: 10).animate(controller);

    // Listen for animation completion to trigger navigation
    controller.addListener(() {
      if (controller.isCompleted) {
        // Navigate to the next screen with a fade transition
        Navigator.push(
          context,
          FadePageRoute(page: const Destination()),
        );

        // Reset the animation after a short delay (500ms)
        Timer(
          const Duration(milliseconds: 500),
              () {
            controller.reset();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Start the animation when tapped
            controller.forward();
          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller to free up resources
    controller.dispose();
    super.dispose();
  }
}



// Destination screen after animation completes
class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}


// Custom transition class for a smooth fade effect
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: child,
      );
    },
  );
}