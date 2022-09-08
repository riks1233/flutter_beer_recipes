import 'package:flutter/material.dart';

class TextBlockQuote extends StatelessWidget {
  const TextBlockQuote(this.quote, {super.key});

  final String quote;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.format_quote_rounded,
          size: 32,
          color: Colors.grey.shade400,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            quote,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
