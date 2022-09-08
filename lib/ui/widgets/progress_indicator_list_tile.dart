import 'package:flutter/material.dart';

/// A [CircularProgressIndicator] to be included as a list tile for [ListView] to indicate
/// further loading of the elements.
class ProgressIndicatorListTile extends StatelessWidget {
  const ProgressIndicatorListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
