import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:entain_beer_task_richardas/ui/widgets/text_block/text_block.dart';

class BeerDetailsTextBlock extends StatelessWidget {
  const BeerDetailsTextBlock({required this.beer, super.key});

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._introduction(),
        ..._foodPairings(),
        ..._brewing(),
        ..._otherSpecs(),
        const SizedBox(height: 50),
      ],
    );
  }

  List<Widget> _introduction() {
    return [
      const SizedBox(height: 8),
      Text('${beer.name}',
          style: const TextStyle(
              height: 1, fontSize: 32, fontWeight: FontWeight.w500)),
      TextBlockHeading3('by ${beer.contributed_by ?? 'unknown'}'),
      const SizedBox(height: 8),
      TextBlockBodyText('${beer.description}'),
      const SizedBox(height: 16),
      TextBlockQuote('${beer.tagline}'),
    ];
  }

  List<Widget> _foodPairings() {
    return [
      const TextBlockHeading1('Food pairings'),
      TextBlockBulletList(stringList: beer.food_pairing),
    ];
  }

  List<Widget> _brewing() {
    return [
      const TextBlockHeading1('Brewing'),
      TextBlockBodyText('First brewed in ${beer.first_brewed}.'),
      ..._ingredients(),
      ..._method(),
      ..._volumes(),
      const TextBlockHeading2('Tips'),
      TextBlockBodyText('${beer.brewers_tips}'),
    ];
  }

  List<Widget> _ingredients() {
    return [
      const TextBlockHeading2('Ingredients'),
      const TextBlockHeading3('Malt'),
      TextBlockBulletList(
          stringList: beer.ingredients?.malt
              ?.map((maltItem) =>
                  '${maltItem.name} - ${maltItem.amount?.value} ${maltItem.amount?.unit}')
              .toList()),
      const TextBlockHeading3('Hops'),
      TextBlockBulletList(
          stringList: beer.ingredients?.hops
              ?.map((hopItem) =>
                  '${hopItem.name} (${hopItem.attribute}) - ${hopItem.amount?.value} ${hopItem.amount?.unit} (add: ${hopItem.add})')
              .toList()),
      const TextBlockHeading3('Yeast'),
      TextBlockBulletList(stringList: ['${beer.ingredients?.yeast}']),
    ];
  }

  List<Widget> _method() {
    return [
      const TextBlockHeading2('Method'),
      const TextBlockHeading3('Mash temperatures'),
      TextBlockBulletList(
          stringList: beer.method?.mash_temp
              ?.map((mashItem) =>
                  '${mashItem.temp?.value}\u00B0 ${mashItem.temp?.unit} (duration: ${mashItem.duration ?? 'unknown'})')
              .toList()),
      const TextBlockHeading3('Fermentation'),
      TextBlockBodyText(
          '${beer.method?.fermentation?.temp?.value}\u00B0 ${beer.method?.fermentation?.temp?.unit}'),
      const TextBlockHeading3('Twist'),
      TextBlockBodyText(beer.method?.twist ?? 'unknown'),
    ];
  }

  List<Widget> _volumes() {
    return [
      const TextBlockHeading2('Volumes'),
      TextBlockBulletList(stringList: [
        'Still: ${beer.volume?.value} ${beer.volume?.unit}',
        'Boil: ${beer.boil_volume?.value} ${beer.boil_volume?.unit}',
      ]),
    ];
  }

  List<Widget> _otherSpecs() {
    return [
      const TextBlockHeading1('Other specs'),
      TextBlockBulletList(stringList: [
        'ABV: ${beer.abv ?? 'unknown'}',
        'IBU: ${beer.ibu ?? 'unknown'}',
        'Target FG: ${beer.target_fg ?? 'unknown'}',
        'Target OG: ${beer.target_og ?? 'unknown'}',
        'EBC: ${beer.ebc ?? 'unknown'}',
        'SRM: ${beer.srm ?? 'unknown'}',
        'pH: ${beer.ph ?? 'unknown'}',
      ]),
    ];
  }
}
