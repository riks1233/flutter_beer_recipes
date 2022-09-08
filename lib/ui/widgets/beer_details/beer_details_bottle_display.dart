import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/ui/widgets/animated_transform_horizontal_slide.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:transparent_image/transparent_image.dart';

class BeerDetailsBottleDisplay extends StatelessWidget {
  const BeerDetailsBottleDisplay({required this.beer, super.key});

  final Beer beer;
  final Curve animationCurve = Curves.decelerate;
  final Duration animationDuration =
      const Duration(seconds: 1, milliseconds: 200);
  // It should be safe to use hardcoded values in this widget, because the app is intended to be
  // used only in portrait mode and only on mobile devices.
  static const double beerImageMaxHeight = 350;
  static const double beerImageMaxWidth = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Stack(
        children: [
          Center(
            child: AnimatedTransformHorizontalSlide(
              childStartOffset: const Offset(-88, 20),
              tweenDeltaX: 8,
              curve: animationCurve,
              duration: animationDuration,
              child: Text(
                '${beer.name}',
                softWrap: false,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 200,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFE4E4E4),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedTransformHorizontalSlide(
              childStartOffset: const Offset(85, 160),
              tweenDeltaX: 15,
              curve: animationCurve,
              duration: animationDuration,
              child: Text(
                '${beer.tagline}',
                softWrap: false,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFD8D8D8),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: beerImageMaxHeight,
              width: beerImageMaxWidth,
              child: AnimatedTransformHorizontalSlide(
                childStartOffset: const Offset(15, 0),
                tweenDeltaX: -15,
                curve: animationCurve,
                duration: animationDuration,
                child: beer.image_url == null
                    ? null
                    : FadeInImage.memoryNetwork(
                        fit: BoxFit.contain,
                        fadeOutDuration: const Duration(milliseconds: 1),
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: kTransparentImage,
                        image: beer.image_url!,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
