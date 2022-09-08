import 'package:flutter/material.dart';

/// Creates a [Transform] horizontal slide animation. Starts animating on build/spawn.
class AnimatedTransformHorizontalSlide extends StatelessWidget {
  AnimatedTransformHorizontalSlide(
      {required this.childStartOffset,
      required this.tweenDeltaX,
      required this.curve,
      required this.child,
      required this.duration,
      super.key})
      : xPosTween = Tween<double>(
            begin: childStartOffset.dx, end: childStartOffset.dx + tweenDeltaX);

  final Offset childStartOffset;
  final double tweenDeltaX;
  final Curve curve;
  final Duration duration;
  final Widget? child;

  final Tween<double> xPosTween;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: xPosTween,
      curve: curve,
      duration: duration,
      builder: (context, xPos, builderChild) {
        return Transform.translate(
          offset: Offset(xPos, childStartOffset.dy),
          child: builderChild,
        );
      },
      child: child,
    );
  }
}
