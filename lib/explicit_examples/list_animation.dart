import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<Offset>> slideAnimation = [];
  bool isClicked = true;
  int itemCount = 5;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a 3-second duration
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    // Create a list of slide animations for each list item
    slideAnimation = List.generate(
        itemCount,
            (index) => Tween<Offset>(
          begin: const Offset(-1, 0), // Start off-screen (left)
          end: Offset.zero, // End at normal position
        ).animate(CurvedAnimation(
            parent: controller,
            // Each item's animation starts at a slightly different interval
            curve: Interval((index * (1 / itemCount)), 1))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SlideTransition(
            // Apply the slide animation to each list item
            position: slideAnimation[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // If the animation is completed, reverse it, otherwise play it forward
          controller.isCompleted ? controller.reverse() : controller.forward();
        },
        child: const Icon(Icons.done),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the animation controller to free up resources
    super.dispose();
  }
}
