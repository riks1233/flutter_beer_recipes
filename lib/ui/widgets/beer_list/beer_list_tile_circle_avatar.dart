import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:transparent_image/transparent_image.dart';

class BeerListTileCircleAvatar extends StatelessWidget {
  const BeerListTileCircleAvatar({required this.beer, super.key});

  final Beer beer;
  static const double beerImageMaxWidth = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: beerImageMaxWidth,
              child: Transform.rotate(
                angle: -20 * 3.14 / 180,
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
          )
        ],
      ),
    );
  }
}
