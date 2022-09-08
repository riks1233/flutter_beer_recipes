import 'package:flutter/material.dart';

class TextBlockBodyText extends StatelessWidget {
  const TextBlockBodyText(this.data, {
    this.color,
    super.key
  });

  final String data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: color ?? Colors.grey.shade700),
    );
  }
}
