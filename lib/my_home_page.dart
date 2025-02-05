import 'package:animation_starter_code/page_route_builder_animation/splash_animation.dart';
import 'package:flutter/material.dart';

import 'custom_painter_example/bouncing_ball_animation.dart';
import 'custom_painter_example/pulsing_heart.dart';
import 'explicit_examples/list_animation.dart';
import 'explicit_examples/loading_animation.dart';
import 'explicit_examples/login_animation.dart';
import 'implicit_examples/animated_color_pallete.dart';
import 'implicit_examples/animated_shopping_cart_button.dart';
import 'implicit_examples/animated_tween_animation_builder_example.dart';



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Animations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnimatedColorPalette() ),
            );
          }, child: const Text('AnimatedColorPalette')),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShoppingCartButton( )),
              );
            }, child: const Text('Shopping Cart Button')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PulsatingCircleAnimation() ),
              );
            }, child: const Text('PulsatingCircleAnimation')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PulsatingHeartAnimation() ),
              );
            }, child: const Text('PulsatingHeartAnimation')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  const LoginScreenAnimation()),
              );
            }, child: const Text('Login Screen Animation')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  const ListAnimation()),
              );
            }, child: const Text('List Screen Animation')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  const RadialProgressAnimation(progress: 0.65, color: Colors.blue,)),
              );
            }, child: const Text('Radial Progress Animation')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  const BouncingBallAnimation()),
              );
            }, child: const Text('Bouncing Ball Animation')),

            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  const SplashAnimation()),
              );
            }, child: const Text('Splash Animation'))
          ],
        ),
      ),
    );
  }
}
