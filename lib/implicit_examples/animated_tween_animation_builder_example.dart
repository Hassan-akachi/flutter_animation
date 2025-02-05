import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatelessWidget {
  const PulsatingCircleAnimation({super.key});
  //final double size = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulsating Circle Animation'),
      ),
      body: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0,end: 200),
          duration: const Duration(milliseconds: 1500),
        child: const Text('Hello World '), // child is const and does not rebuild during animation,saves resources
        builder: (context,size,widget) {
          return Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellowAccent.withOpacity(0.5),
                    blurRadius: size,
                    spreadRadius: size / 2,
                  ),
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    blurRadius: size,
                    spreadRadius: size / 2,
                  ),
                ],
              ),
              child: widget,
            ),
          );

        }

      ),
    );
  }
}
