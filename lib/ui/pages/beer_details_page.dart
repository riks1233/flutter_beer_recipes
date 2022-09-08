import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_details/beer_details_body.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:entain_beer_task_richardas/ui/pages/page_wrapper.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_details/beer_details_bottle_display.dart';
import 'package:entain_beer_task_richardas/ui/widgets/circular_elevated_button.dart';

class BeerDetailsPage extends StatelessWidget {
  BeerDetailsPage({required this.beer, super.key});

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: Colors.grey.shade200,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                BeerDetailsBottleDisplayX(beer: beer),
                BeerDetailsBody(beer: beer),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: CircularElevatedButton(
                iconData: Icons.arrow_back_rounded,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


