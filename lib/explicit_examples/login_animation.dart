import 'package:flutter/material.dart';

class LoginScreenAnimation extends StatefulWidget {
  const LoginScreenAnimation({super.key});

  @override
  State<LoginScreenAnimation> createState() => _LoginScreenAnimationState();
}

class _LoginScreenAnimationState extends State<LoginScreenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> logoOpacityAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController to control all animations
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500));

    // Opacity animation for the logo (fades in from 30% opacity to full visibility)
    logoOpacityAnimation =
        Tween<double>(begin: 0.3, end: 1).animate(controller);

    // Slide animation for the form (moves in from the top-right corner to its normal position)
    slideAnimation = Tween<Offset>(begin: const Offset(-1, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    // Scale animation for the form (starts small and expands to full size smoothly)
    scaleAnimation = Tween<double>(begin: 0.3, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    // Start the animations automatically
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade animation applied to the Flutter logo
            FadeTransition(
              opacity: logoOpacityAnimation,
              child: const FlutterLogo(
                size: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SlideTransition(
                position: slideAnimation, // Apply slide animation to the form
                child: ScaleTransition(
                  scale: scaleAnimation, // Apply scale animation to the form
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }
}
