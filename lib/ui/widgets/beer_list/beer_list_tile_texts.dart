import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';

class BeerListTileTexts extends StatelessWidget {
  const BeerListTileTexts({required this.beer, super.key});

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            beer.name ?? '<unknown>',
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'by ${beer.contributed_by ?? '<unknown>'}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Text(
            beer.description ?? '<unknown>',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
