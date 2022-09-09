import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list_tile_texts.dart';
import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list_tile_circle_avatar.dart';
import 'package:entain_beer_task_richardas/ui/pages/beer_details_page.dart';

class BeerListTile extends StatelessWidget {
  const BeerListTile({required this.beer, super.key});

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BeerDetailsPage(beer: beer),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  BeerListTileCircleAvatar(
                    beer: beer,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  BeerListTileTexts(beer: beer)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
