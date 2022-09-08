import 'dart:convert';
import 'dart:developer';

import 'package:entain_beer_task_richardas/ui/pages/beer_details_page.dart';
import 'package:entain_beer_task_richardas/ui/pages/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:transparent_image/transparent_image.dart';

class BeersListPage extends StatefulWidget {
  const BeersListPage({super.key});

  @override
  State<BeersListPage> createState() => _BeersListPageState();
}

class _BeersListPageState extends State<BeersListPage> {
  late Future<List<Beer>> beersListFuture;
  List<Beer> beers = [];

  Future<List<Beer>> fetchBeers() async {
    // await Future.delayed(Duration(seconds: 2));
    String beersJson = await rootBundle.loadString('assets/sample_data.json');
    List<dynamic> beersJsonList = jsonDecode(beersJson);
    List<Beer> beersData =
        beersJsonList.map((beerJson) => Beer.fromJson(beerJson)).toList();
    // Don't need to setState().
    beers = beersData;
    return beers;
  }

  @override
  void initState() {
    beersListFuture = fetchBeers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
          future: beersListFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: Text('Waiting for data.'),
                );
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: beers.length * 2,
                  itemBuilder: (context, index) {
                    // log('Built $index');
                    // return Text('Stuff $index');
                    // return Text('Beer ${snapshot.data?.elementAt(index).name ?? 'No name'}');
                    // TODO: Address snapshot might not have data (Johannes mike futurebuilder tutorial.)

                    if (index % 2 == 1) {
                      return SizedBox(height: 8,);
                    }
                    final Beer beer = snapshot.data!.elementAt(index ~/ 2);
                    return BeerListTile(beer: beer);
                  },
                );
              default:
                return const Center(
                  child: Text('Default.'),
                );
            }
          },
        ),
      ),
    );
  }
}

// class BeersList extends StatefulWidget {
//   const BeersList({super.key});

//   @override
//   State<BeersList> createState() => _BeersListState();
// }

// class _BeersListState extends State<BeersList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class BeerListTile extends StatelessWidget {
  const BeerListTile({
    required this.beer,
    super.key
  });

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    log(beer.image_url ?? 'asd');
    return ClipRRect(
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
                        // style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                      ),
                      // SizedBox(height: 8,),
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
    );
  }
}

class BeerCircleAvatar extends StatelessWidget {
  const BeerCircleAvatar({
    required this.beer,
    super.key
  });

  final Beer beer;

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
            child: Transform.rotate(
              angle: -20 * 3.14 / 180,
              // child: imageUrl != null ? Image.network(imageUrl!) : null,
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
          )
        ],
      ),
    );
  }
}
