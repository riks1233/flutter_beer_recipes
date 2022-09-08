import 'package:flutter/material.dart';

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
            offset: const Offset(3, 6), // changes position of shadow
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.all(11),
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
