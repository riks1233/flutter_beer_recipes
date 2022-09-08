import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A page wrapper to combine common properties of pages.
class PageWrapper extends StatelessWidget {
  const PageWrapper({
    required this.child,
    this.backgroundColor,
    super.key
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(child: child),
      ),
    );
  }
}
