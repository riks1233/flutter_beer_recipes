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
                  ?.map((item) => Text(
                        '\u2022  $item',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.grey.shade700),
                      ))
                  .toList() ??
              []),
    );
  }
}
