import 'package:entain_beer_task_richardas/ui/widgets/beer_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/ui/pages/beer_details_page.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';

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
                  BeerCircleAvatar(
                    beer: beer,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          beer.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'by ${beer.contributed_by ?? '<unknown>'}',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                        ),
                        Text(
                          beer.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
