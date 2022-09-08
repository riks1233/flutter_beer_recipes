import 'package:entain_beer_task_richardas/ui/pages/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:transparent_image/transparent_image.dart';

class BeerDetailsPage extends StatelessWidget {
  const BeerDetailsPage({required this.beer, super.key});

  final Beer beer;
  static const double beerImageHeight = 350;
  static const double beerImageWidth = 180;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: Colors.grey.shade200,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Stack(
                    children: [
                      Center(
                        child: Transform.translate(
                          offset: Offset(-80, 20),
                          child: Text(
                            '${beer.name}',
                            softWrap: false,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 200,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFE4E4E4)
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Transform.translate(
                          offset: Offset(100, 160),
                          child: Text(
                            '${beer.tagline}',
                            softWrap: false,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFD8D8D8)
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: beerImageHeight,
                          width: beerImageWidth,
                          child: beer.image_url == null
                              ? null
                              : FadeInImage.memoryNetwork(
                                  fit: BoxFit.contain,
                                  fadeOutDuration:
                                      const Duration(milliseconds: 1),
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  placeholder: kTransparentImage,
                                  image: beer.image_url!,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              spreadRadius: 16,
                              blurRadius: 20,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8,),
                              Text(
                                '${beer.name}',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                              SizedBox(height: 8,),
                              Text(
                                'by ${beer.contributed_by ?? 'unknown'}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade700),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${beer.description}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade600),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.format_quote_rounded,
                                    size: 32,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${beer.tagline}',
                                      softWrap: true,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                              _cardHeading1('Food pairings'),
                              _textsBulletList(Theme.of(context), beer.food_pairing ?? []),
                              _cardHeading1('Brewing'),
                              Text(
                                'First brewed in ${beer.first_brewed}.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade700),
                              ),
                              _cardHeading2('Ingredients'),
                              _cardHeading3('Malt'),
                              _textsBulletList(
                                Theme.of(context),
                                beer.ingredients?.malt?.map((maltItem) => '${maltItem.name} - ${maltItem.amount?.value} ${maltItem.amount?.unit}').toList() ?? []
                              ),
                              _cardHeading3('Hops'),
                              _textsBulletList(
                                Theme.of(context),
                                beer.ingredients?.hops?.map((hopItem) => '${hopItem.name} (${hopItem.attribute}) - ${hopItem.amount?.value} ${hopItem.amount?.unit} (add: ${hopItem.add})').toList() ?? []
                              ),
                              _cardHeading3('Yeast'),
                              _textsBulletList(Theme.of(context), ['${beer.ingredients?.yeast}']),
                              _cardHeading2('Method'),
                              _cardHeading3('Mash temperatures'),
                              _textsBulletList(
                                Theme.of(context),
                                beer.method?.mash_temp?.map((mashItem) => '${mashItem.temp?.value}\u00B0 ${mashItem.temp?.unit} (duration: ${mashItem.duration ?? 'unknown'})').toList() ?? []
                              ),
                              _cardHeading3('Fermentation'),
                              Text(
                                '${beer.method?.fermentation?.temp?.value}\u00B0 ${beer.method?.fermentation?.temp?.unit}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade700),
                              ),
                              _cardHeading3('Twist'),
                              Text(
                                '${beer.method?.twist ?? 'unknown'}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade700),
                              ),
                              _cardHeading2('Volumes'),
                              _textsBulletList(
                                Theme.of(context),
                                [
                                  'Still: ${beer.volume?.value} ${beer.volume?.unit}',
                                  'Boil: ${beer.boil_volume?.value} ${beer.boil_volume?.unit}',
                                ]
                              ),
                              _cardHeading2('Tips'),
                              Text(
                                '${beer.brewers_tips}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade700),
                              ),
                              _cardHeading1('Other specs'),
                              _textsBulletList(
                                Theme.of(context),
                                [
                                  'ABV: ${beer.abv ?? 'unknown'}',
                                  'IBU: ${beer.ibu ?? 'unknown'}',
                                  'Target FG: ${beer.target_fg ?? 'unknown'}',
                                  'Target OG: ${beer.target_og ?? 'unknown'}',
                                  'EBC: ${beer.ebc ?? 'unknown'}',
                                  'SRM: ${beer.srm ?? 'unknown'}',
                                  'pH: ${beer.ph ?? 'unknown'}',
                                ]
                              ),
                              SizedBox(height: 50,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            // child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_rounded)),
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

  Widget _textsBulletList(ThemeData themeData, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => Text(
          '\u2022  $item',
          style: themeData
          .textTheme
          .bodyText2!
          .copyWith(color: Colors.grey.shade700),
        )).toList()
      ),
    );
  }

  Widget _cardHeading1(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24,),
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900
          )
        ),
        SizedBox(height: 8,),
      ],
    );
  }
  Widget _cardHeading2(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8,),
      ],
    );
  }
  Widget _cardHeading3(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 8,),
      ],
    );
  }
}

class CircularElevatedButton extends StatelessWidget {
  const CircularElevatedButton({
    Key? key,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(3, 6), // changes position of shadow
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        shape: CircleBorder(),
        child: InkWell(
          onTap: onTap ?? () {},
          child: Padding(
            padding: EdgeInsets.all(11),
            child: Icon(
              iconData,
              size: 26,
              color: Colors.grey.shade700,
            ),
          ),
        ),

      ),
    );
  }
}
