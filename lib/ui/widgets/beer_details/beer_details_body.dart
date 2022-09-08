import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_details/beer_details_text_block.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';

class BeerDetailsBody extends StatelessWidget {
  const BeerDetailsBody({required this.beer, super.key});

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  spreadRadius: 16,
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: BeerDetailsTextBlock(beer: beer),
          ),
        ),
      ],
    );
  }
}
