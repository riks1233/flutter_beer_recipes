import 'package:flutter/material.dart';

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
