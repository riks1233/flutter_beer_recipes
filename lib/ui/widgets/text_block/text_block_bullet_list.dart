import 'package:entain_beer_task_richardas/ui/widgets/text_block/text_block_bodytext.dart';
import 'package:flutter/material.dart';

class TextBlockBulletList extends StatelessWidget {
  const TextBlockBulletList({this.stringList, super.key});

  final List<String>? stringList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stringList
                  ?.map((item) => TextBlockBodyText('\u2022  $item'))
                  .toList() ??
              []),
    );
  }
}
