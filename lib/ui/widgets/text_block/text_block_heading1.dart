import 'package:flutter/material.dart';

class TextBlockHeading1 extends StatelessWidget {
  const TextBlockHeading1(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
