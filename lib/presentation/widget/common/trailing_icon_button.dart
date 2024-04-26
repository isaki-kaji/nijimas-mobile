import 'package:flutter/material.dart';

class TrailingIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  const TrailingIconButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(onPressed: onPressed, icon: Icon(icon), iconSize: 30.0),
    );
  }
}
