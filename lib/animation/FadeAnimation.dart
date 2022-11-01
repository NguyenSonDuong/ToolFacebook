import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
    ..tween('opacity', Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 500))
        .thenTween('translateY', Tween(begin: -30.0, end: 0.0),
    duration: const Duration(seconds: 1),curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      tween: tween, // Pass in tween
      duration: tween.duration, // Obtain duration
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get('opacity'), // Get animated values
          child: Transform.translate(
              offset: Offset(0, value.get("translateY")),
              child: child
          ),
        );
      },
    );
  }
}