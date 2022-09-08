import 'package:flutter/material.dart';

class TextBlockHeading3 extends StatelessWidget {
  const TextBlockHeading3(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
